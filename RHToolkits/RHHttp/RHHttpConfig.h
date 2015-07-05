//
//  RHHttpConfig.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#ifndef RHToolkit_RHHttpConfig_h
#define RHToolkit_RHHttpConfig_h

#ifdef DEBUG
#define RHHttpDebug
#endif

#ifdef RHHttpDebug
#define RHHttpLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHHttpLog(format, ...)
#endif

#define DEFAULT_HTTP_URL    @"http://www.baidu.com"

#endif
