//
//  NSObject+Log.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define RHLogDebug
#endif

#ifdef RHLogDebug
#define RHLogLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHLogLog(format, ...)
#endif

@interface NSObject (Log)

- (void)logWithMark:(NSString *)mark;
- (void)log;

@end
