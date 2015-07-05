//
//  RHAudioCafOutput.m
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHAudioCafOutput.h"
#import "NSFileManager+App.h"

@interface RHAudioCafOutput ()
{
    AudioStreamBasicDescription _audioFormat;
    AudioFileID _audioFile;
    SInt64 _audioPacket;
}

@end

@implementation RHAudioCafOutput

- (instancetype)init
{
    if (self = [super init]) {
        _filePath = [self filePathOfAudioFile];
    }
    return self;
}

- (NSString *)filePathOfAudioFile
{
    NSString *name = [NSString stringWithFormat:@"audio_output_%lu.caf", clock()];
    NSString *path = [NSString stringWithFormat:@"%@/%@", [NSFileManager cacheDirectory], name];
    return path;
}

- (void)dealloc
{
    [self closeAudioFile];
}

#pragma mark -
#pragma mark RHAudioOutputDelegate method

- (AudioStreamBasicDescription)setupAudioFormat
{
    //初始化_audioFormat
    memset(&_audioFormat, 0, sizeof(_audioFormat));
    
    //采样率的意思是每秒需要采集的帧数 [默认使用获取系统属]
    _audioFormat.mSampleRate = 8000;//[AVAudioSession sharedInstance].sampleRate;
    
    //设置通道数,这里先使用系统的测试下
    _audioFormat.mChannelsPerFrame = 1;//(UInt32)[AVAudioSession sharedInstance].inputNumberOfChannels;
    
    //设置formatID
    _audioFormat.mFormatID = kAudioFormatLinearPCM;
    
    // if we want pcm, default to signed 16-bit little-endian
    _audioFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    //每个通道里，一帧采集的bit数目
    _audioFormat.mBitsPerChannel = 16;
    //结果分析: 8bit为1byte，即为1个通道里1帧需要采集2byte数据，再*通道数，即为所有通道采集的byte数目。
    //所以这里结果赋值给每帧需要采集的byte数目，然后这里的packet也等于一帧的数据。
    //至于为什么要这样。。。不知道。。。
    _audioFormat.mBytesPerPacket = _audioFormat.mBytesPerFrame = (_audioFormat.mBitsPerChannel / 8) * _audioFormat.mChannelsPerFrame;
    _audioFormat.mFramesPerPacket = 1;
    
    return _audioFormat;
}

- (BOOL)createAudioFile
{
    _audioPacket = 0;
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, (CFStringRef)_filePath, NULL);
    
    OSStatus status = AudioFileCreateWithURL(url, kAudioFileCAFType, &_audioFormat, kAudioFileFlags_EraseFile, &_audioFile);
    if (status != noErr) {
        return NO;
    }
    
    CFRelease(url);
    return YES;
}

- (void)copyEncoderCookieToFile:(AudioQueueRef)inAQ
{
    UInt32 propertySize;
    // get the magic cookie, if any, from the converter
    OSStatus status = AudioQueueGetPropertySize(inAQ, kAudioQueueProperty_MagicCookie, &propertySize);
    
    // we can get a noErr result and also a propertySize == 0
    // -- if the file format does support magic cookies, but this file doesn't have one.
    if (status == noErr && propertySize > 0) {
        Byte magicCookie[propertySize];
        UInt32 magicCookieSize;
        status = AudioQueueGetProperty(inAQ, kAudioQueueProperty_MagicCookie, magicCookie, &propertySize);
        NSAssert(status == noErr, @"get audio converter's magic cookie");
        magicCookieSize = propertySize;	// the converter lies and tell us the wrong size
        
        // now set the magic cookie on the output file
        UInt32 willEatTheCookie = false;
        // the converter wants to give us one; will the file take it?
        status = AudioFileGetPropertyInfo(_audioFile, kAudioFilePropertyMagicCookieData, NULL, &willEatTheCookie);
        if (status == noErr && willEatTheCookie) {
            status = AudioFileSetProperty(_audioFile, kAudioFilePropertyMagicCookieData, magicCookieSize, magicCookie);
            if (status != noErr) {
                RHAudioLog(@"set audio file's magic cookie");
            }
        }
    }
}

- (BOOL)writeAudioFile:(AudioQueueRef)inAQ inBuffer:(AudioQueueBufferRef)inBuffer inPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc inNumPackets:(UInt32)inNumPackets
{
    OSStatus status = AudioFileWritePackets(_audioFile, FALSE, inBuffer->mAudioDataByteSize, inPacketDesc, _audioPacket, &inNumPackets, inBuffer->mAudioData);
    if (status != noErr) {
        return NO;
    }
    
    _audioPacket += inNumPackets;
    return YES;
}

- (void)closeAudioFile
{
    AudioFileClose(_audioFile);
}

@end
