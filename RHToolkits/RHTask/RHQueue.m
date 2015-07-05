//
//  RHQueue.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHQueue.h"

@implementation RHQueue

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (dispatch_queue_t)getQueue
{
    return dispatch_get_main_queue();
}

- (void)addTask:(id<RHRunnableProtocol>)task
{
    dispatch_block_t taskBlock = ^{
        [task execute];
    };
    dispatch_async([self getQueue], taskBlock);
}

@end
