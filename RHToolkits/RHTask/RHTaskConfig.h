//
//  RHTaskConfig.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#ifndef RHToolkit_RHTaskConfig_h
#define RHToolkit_RHTaskConfig_h

#ifdef DEBUG
#define RHTaskDebug
#endif

#ifdef RHTaskDebug
#define RHTaskLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHTaskLog(format, ...)
#endif

#endif
