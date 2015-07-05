//
//  RHAudioMp3Output.m
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHAudioMp3Output.h"
#import "lame.h"
#import "NSFileManager+App.h"

@interface RHAudioMp3Output ()
{
    FILE *_file;
    lame_t _lame;
}

@end

@implementation RHAudioMp3Output

- (instancetype)init
{
    if (self = [super init]) {
        _filePath = [self filePathOfAudioFile];
    }
    return self;
}

- (NSString *)filePathOfAudioFile
{
    NSString *name = [NSString stringWithFormat:@"audio_output_%lu.mp3", clock()];
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
    //mp3压缩参数
    _lame = lame_init();
    lame_set_num_channels(_lame, 1);
    lame_set_in_samplerate(_lame, 8000);
    lame_set_out_samplerate(_lame, 8000);
    lame_set_brate(_lame, 128);
    lame_set_mode(_lame, JOINT_STEREO);
    lame_set_quality(_lame, 2);
    lame_init_params(_lame);
    
    //建立mp3文件
    _file = fopen(_filePath.UTF8String, "wb+");
    if (_file == NULL) {
        return NO;
    }
    
    RHAudioLog(@"_filePath: %@", _filePath);
    return YES;
}

- (BOOL)writeAudioFile:(AudioQueueRef)inAQ inBuffer:(AudioQueueBufferRef)inBuffer inPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc inNumPackets:(UInt32)inNumPackets
{
    short *audioData = inBuffer->mAudioData;
    UInt32 pcmLen = inBuffer->mAudioDataByteSize;
    if (pcmLen < 2) {
        return NO;
    }
    
    int nsamples = pcmLen / 2;
    unsigned char buffer[pcmLen];
    //mp3 encode
    int recvLen = lame_encode_buffer(_lame, audioData, audioData, nsamples, buffer, pcmLen);
    if (fwrite(buffer, 1, recvLen, _file) == 0) {
        return NO;
    }
    
    return YES;
}

- (void)closeAudioFile
{
    if (_file) {
        fclose(_file);
        _file = NULL;
    }
    
    if (_lame) {
        lame_close(_lame);
        _lame = NULL;
    }
}

@end
