//
//  RHAudioRecorder.m
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHAudioRecorder.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "RHAudioConfig.h"

//缓存区的个数，3个一般不用改
#define kNumberAudioQueueBuffers 3

//每次的音频输入队列缓存区所保存的是多少秒的数据
#define kBufferDurationSeconds 0.26

@interface RHAudioRecorder ()
{
    AudioQueueRef _audioQueue;                                          //音频输入队列
    AudioQueueBufferRef _audioBuffers[kNumberAudioQueueBuffers];        //音频输入缓冲区
}

@end

@implementation RHAudioRecorder

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInterruption:) name:AVAudioSessionInterruptionNotification object:nil];
        _output = [[RHAudioCafOutput alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (AudioStreamBasicDescription)setupAudioFormat:(UInt32)inFormatID sampleRate:(Float64)sampleRate
{
    AudioStreamBasicDescription tempAudioFormat;
    
    //初始化_audioFormat
    memset(&tempAudioFormat, 0, sizeof(tempAudioFormat));
    
    //采样率的意思是每秒需要采集的帧数 [默认使用获取系统属]
    tempAudioFormat.mSampleRate = 8000;//[AVAudioSession sharedInstance].sampleRate;
    
    //设置通道数,这里先使用系统的测试下
    tempAudioFormat.mChannelsPerFrame = 1;//(UInt32)[AVAudioSession sharedInstance].inputNumberOfChannels;
    
    //设置formatID
    tempAudioFormat.mFormatID = inFormatID;
    
    if (kAudioFormatLinearPCM == inFormatID) {
        // if we want pcm, default to signed 16-bit little-endian
        tempAudioFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        //每个通道里，一帧采集的bit数目
        tempAudioFormat.mBitsPerChannel = 16;
        //结果分析: 8bit为1byte，即为1个通道里1帧需要采集2byte数据，再*通道数，即为所有通道采集的byte数目。
        //所以这里结果赋值给每帧需要采集的byte数目，然后这里的packet也等于一帧的数据。
        //至于为什么要这样。。。不知道。。。
        tempAudioFormat.mBytesPerPacket = tempAudioFormat.mBytesPerFrame = (tempAudioFormat.mBitsPerChannel / 8) * tempAudioFormat.mChannelsPerFrame;
        tempAudioFormat.mFramesPerPacket = 1;
    }
    
    return tempAudioFormat;
}

- (UInt32)computeRecordBufferSize:(const AudioStreamBasicDescription *)format seconds:(float)seconds
{
    UInt32 bytes = 0;
    
    @try {
        UInt32 frames = ceil(seconds * format->mSampleRate);
        
        if (format->mBytesPerFrame > 0) {
            bytes = frames * format->mBytesPerFrame;
        } else {
            UInt32 maxPacketSize;
            if (format->mBytesPerPacket > 0) {
                maxPacketSize = format->mBytesPerPacket;// constant packet size
            } else {
                UInt32 propertySize = sizeof(maxPacketSize);
                OSStatus status = AudioQueueGetProperty(_audioQueue, kAudioQueueProperty_MaximumOutputPacketSize, &maxPacketSize, &propertySize);
                NSAssert(status == noErr, @"couldn't get queue's maximum output packet size");
            }//if
            UInt32 packets = 0;
            if (format->mFramesPerPacket > 0) {
                packets = frames / format->mFramesPerPacket;
            } else {
                packets = frames;// worst-case scenario: 1 frame in a packet
            }//if
            if (packets == 0) {// sanity check
                packets = 1;
            }
            bytes = packets * maxPacketSize;
        }
    }
    @catch (NSException *exception) {
        RHAudioLog(@"computeRecordBufferSize exception: %@", exception.description);
    }
    
    return bytes;
}

void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc)
{
    RHAudioLog(@"inNumPackets: %d", inNumPackets);
    
    @try {
        RHAudioRecorder *recorder = (__bridge RHAudioRecorder *)(inUserData);
        
        if (inNumPackets > 0) {
            [recorder.output writeAudioFile:inAQ inBuffer:inBuffer inPacketDesc:inPacketDesc inNumPackets:inNumPackets];
        }//
        
        // if we're not stopping, re-enqueue the buffe so that it gets filled again
        if (recorder.isRunning) {
            OSStatus status = AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
            if (status != noErr) {
                RHAudioLog(@"AudioQueueEnqueueBuffer failed");
            }
        }
    }
    @catch (NSException *exception) {
        RHAudioLog(@"inputBufferHandler exception: %@", exception.description);
    }//try
}

- (void)start
{
    if (_delegate && [_delegate respondsToSelector:@selector(willRecordStart)]) {
        [_delegate willRecordStart];
    }
    
    @try {
        NSError *error = nil;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        if (error) {
            [self postErrorWithErrorCode:RHAudioRecorderErrorCodeSession];
            return;
        }
        
        // specify the recording format
        AudioStreamBasicDescription audioFormat;
        if ([_output respondsToSelector:@selector(setupAudioFormat)]) {
            audioFormat = [_output setupAudioFormat];
        } else {
            audioFormat = [self setupAudioFormat:kAudioFormatLinearPCM sampleRate:8000];
        }
        
        // create the queue
        OSStatus status = AudioQueueNewInput(&audioFormat, inputBufferHandler, (__bridge void *)(self), NULL, NULL, 0, &_audioQueue);
        if (status != noErr) {
            [self postErrorWithErrorCode:RHAudioRecorderErrorCodeQueue];
            return;
        }
        
        // create the audio file
        [_output createAudioFile];
        
        // copy the cookie first to give the file object as much info as we can about the data going in
        // not necessary for pcm, but required for some compressed audio
        if ([_output respondsToSelector:@selector(copyEncoderCookieToFile:)]) {
            [_output copyEncoderCookieToFile:_audioQueue];
        }
        
        // allocate and enqueue buffers
        UInt32 bufferByteSize = [self computeRecordBufferSize:&audioFormat seconds:kBufferDurationSeconds];
        for (int i=0; i<kNumberAudioQueueBuffers; ++i) {
            status = AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
            NSAssert(status == noErr, @"AudioQueueAllocateBuffer failed");
            status = AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);
            NSAssert(status == noErr, @"AudioQueueEnqueueBuffer failed");
        }
        
        // start the queue
        _isRunning = YES;
        status = AudioQueueStart(_audioQueue, NULL);
        NSAssert(status == noErr, @"AudioQueueStart failed");
    }
    @catch (NSException *exception) {
        RHAudioLog(@"RHAudioRecorder start: %@", exception.description);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didRecordStart)]) {
        [_delegate didRecordStart];
    }
}

- (void)stop
{
    if (!self.isRunning) {
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(willRecordStop)]) {
        [_delegate willRecordStop];
    }
    
    self.isRunning = NO;
    OSStatus status = AudioQueueStop(_audioQueue, true);
    NSAssert(status == noErr, @"AudioQueueStop failed");
    
    // a codec may update its cookie at the end of an encoding session, so reapply it to the file now
    if ([_output respondsToSelector:@selector(copyEncoderCookieToFile:)]) {
        [_output copyEncoderCookieToFile:_audioQueue];
    }
    
    AudioQueueDispose(_audioQueue, true);
    [_output closeAudioFile];
    
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didRecordStop)]) {
        [_delegate didRecordStop];
    }
}

- (void)postErrorWithErrorCode:(RHAudioRecorderErrorCode)errorCode
{
    RHAudioLog(@"postErrorWithErrorCode: %lu", (unsigned long)errorCode);
    
    NSDictionary *userInfo = nil;
    NSError *error = nil;
    
    switch (errorCode) {
        case RHAudioRecorderErrorCodeFile: {
            error = [[NSError alloc] initWithDomain:@"" code:errorCode userInfo:userInfo];
            break;
        }
        case RHAudioRecorderErrorCodeQueue: {
            //
            break;
        }
        case RHAudioRecorderErrorCodeSession: {
            //
            break;
        }
        case RHAudioRecorderErrorCodeUnknown: {
            //
            break;
        }
        default: {
            break;
        }
    }//switch
    
    if (_delegate && [_delegate respondsToSelector:@selector(recorderError:)]) {
        [_delegate recorderError:error];
    }
}

#pragma mark -
#pragma mark sessionInterruption method

- (void)sessionInterruption:(NSNotification *)notif
{
    NSDictionary *userInfo = notif.userInfo;
    AVAudioSessionInterruptionType interruptionType = [userInfo[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    switch (interruptionType) {
        case AVAudioSessionInterruptionTypeBegan: {
            RHAudioLog(@"AVAudioSessionInterruptionTypeBegan...");
            break;
        }
        case AVAudioSessionInterruptionTypeEnded: {
            RHAudioLog(@"AVAudioSessionInterruptionTypeEnded...");
            break;
        }
        default: {
            break;
        }
    }//switch
}

@end
