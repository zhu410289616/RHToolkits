//
//  RHAudioMp3Output.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHAudioOutputDelegate.h"

/**
 *  一般使用采样率 8000 缓冲区秒数为0.5
 */
@interface RHAudioMp3Output : NSObject <RHAudioOutputDelegate>

@property (nonatomic, copy) NSString *filePath;

@end
