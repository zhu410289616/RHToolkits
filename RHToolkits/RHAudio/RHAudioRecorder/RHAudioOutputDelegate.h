//
//  RHAudioOutputDelegate.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RHAudioConfig.h"

@protocol RHAudioOutputDelegate <NSObject>

@required

- (BOOL)createAudioFile;
- (BOOL)writeAudioFile:(AudioQueueRef)inAQ inBuffer:(AudioQueueBufferRef)inBuffer inPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc inNumPackets:(UInt32)inNumPackets;
- (void)closeAudioFile;

@optional

- (AudioStreamBasicDescription)setupAudioFormat;
- (void)copyEncoderCookieToFile:(AudioQueueRef)inAQ;

@end
