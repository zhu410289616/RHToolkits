//
//  RHAudioRecorder.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHAudioCafOutput.h"

typedef NS_ENUM(NSUInteger, RHAudioRecorderErrorCode) {
    RHAudioRecorderErrorCodeFile = 0,           //文件操作错误
    RHAudioRecorderErrorCodeQueue,              //音频队列错误
    RHAudioRecorderErrorCodeSession,            //session错误
    RHAudioRecorderErrorCodeUnknown             //未知错误
};

@protocol RHAudioRecorderDelegate <NSObject>

@optional

- (void)recorderError:(NSError *)error;

- (void)willRecordStart;
- (void)didRecordStart;

- (void)willRecordStop;
- (void)didRecordStop;

@end

@interface RHAudioRecorder : NSObject

@property (nonatomic, strong) id<RHAudioOutputDelegate> output;
@property (atomic, assign) BOOL isRunning;

@property (nonatomic, weak) id<RHAudioRecorderDelegate> delegate;

- (void)start;
- (void)stop;

@end
