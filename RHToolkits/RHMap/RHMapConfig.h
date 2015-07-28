//
//  RHMapConfig.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#ifndef Way_RHMapConfig_h
#define Way_RHMapConfig_h

#ifdef DEBUG
#define RHMapDebug
#endif

#ifdef RHMapDebug
#define RHMapLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHMapLog(format, ...)
#endif

#endif
