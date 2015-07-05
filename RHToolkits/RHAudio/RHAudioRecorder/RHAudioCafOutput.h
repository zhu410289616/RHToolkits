//
//  RHAudioCafOutput.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHAudioOutputDelegate.h"

@interface RHAudioCafOutput : NSObject <RHAudioOutputDelegate>

@property (nonatomic, copy) NSString *filePath;

@end
