//
//  RHConcurrentQueue.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHConcurrentQueue.h"

char *const kLabelConcurrentQueue = "com.zrh.concurrent_queue";

@interface RHConcurrentQueue ()
{
    dispatch_queue_t _queue;
}

@end

@implementation RHConcurrentQueue

- (instancetype)init
{
    if (self = [super init]) {
        _queue = dispatch_queue_create(kLabelConcurrentQueue, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (dispatch_queue_t)getQueue
{
    return _queue;
}

@end
