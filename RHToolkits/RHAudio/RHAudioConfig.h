//
//  RHAudioConfig.h
//  RHAudio
//
//  Created by zhuruhong on 15/6/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#ifndef RHAudio_RHAudioConfig_h
#define RHAudio_RHAudioConfig_h

#define RHAdudioDebug

#ifdef RHAdudioDebug
#define RHAudioLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHAudioLog(format, ...)
#endif

#endif
