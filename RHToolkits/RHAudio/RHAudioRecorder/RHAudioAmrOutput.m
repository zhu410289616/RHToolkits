//
//  RHAudioAmrOutput.m
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHAudioAmrOutput.h"
#import "interf_enc.h"
#import "NSFileManager+App.h"

@interface RHAudioAmrOutput ()
{
    FILE *_file;
    void *_destate;
}

@end

@implementation RHAudioAmrOutput

- (instancetype)init
{
    if (self = [super init]) {
        _filePath = [self filePathOfAudioFile];
    }
    return self;
}

- (NSString *)filePathOfAudioFile
{
    NSString *name = [NSString stringWithFormat:@"audio_output_%lu.amr", clock()];
    NSString *path = [NSString stringWithFormat:@"%@/%@", [NSFileManager cacheDirectory], name];
    return path;
}

- (void)dealloc
{
    [self closeAudioFile];
}

#pragma mark -
#pragma mark RHAudioOutputDelegate method

- (BOOL)createAudioFile
{
    _destate = NULL;
    //amr压缩句柄
    _destate = Encoder_Interface_init(0);
    if (NULL == _destate) {
        return NO;
    }
    
    //建立amr文件
    _file = fopen(_filePath.UTF8String, "wb+");
    if (_file == NULL) {
        return NO;
    }
    
    //写入文件头
    static const char *amrHeader = "#!AMR\n";
    if (fwrite(amrHeader, 1, strlen(amrHeader), _file) == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)writeAudioFile:(AudioQueueRef)inAQ inBuffer:(AudioQueueBufferRef)inBuffer inPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc inNumPackets:(UInt32)inNumPackets
{
    short *audioData = inBuffer->mAudioData;
    UInt32 pcmLen = inBuffer->mAudioDataByteSize;
    if (pcmLen <= 0) {
        return NO;
    }
    
    if (pcmLen % 2 != 0) {
        pcmLen--;//防止意外，如果不是偶数，情愿减去最后一个字节。
    }
    
    unsigned char buffer[320];
    for (int i=0; i<pcmLen; i+=160*2) {
        short *pPacket = (short *)((unsigned char *)audioData+i);
        if (pcmLen-i < 160*2) {
            continue;//不是一个完整的就拜拜
        }
        
        memset(buffer, 0, sizeof(buffer));
        //encode
        int recvLen = Encoder_Interface_Encode(_destate, MR515, pPacket, buffer, 0);
        if (fwrite(buffer, 1, recvLen, _file) == 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)closeAudioFile
{
    if (_file) {
        fclose(_file);
        _file = NULL;
    }
    
    if (_destate) {
        Encoder_Interface_exit(_destate);
        _destate = NULL;
    }
}

@end
