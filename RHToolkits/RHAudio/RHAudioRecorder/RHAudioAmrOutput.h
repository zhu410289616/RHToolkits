//
//  RHAudioAmrOutput.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHAudioOutputDelegate.h"

/**
 *  采样率必须为8000，然后缓冲区秒数必须为0.02的倍数。
 */
@interface RHAudioAmrOutput : NSObject <RHAudioOutputDelegate>

@property (nonatomic, copy) NSString *filePath;

@end
