//
//  RHSerialQueue.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHSerialQueue.h"

char *const kLabelSerialQueue = "com.zrh.serial_queue";

@interface RHSerialQueue ()
{
    dispatch_queue_t _queue;
}

@end

@implementation RHSerialQueue

- (instancetype)init
{
    if (self = [super init]) {
        _queue = dispatch_queue_create(kLabelSerialQueue, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (dispatch_queue_t)getQueue
{
    return _queue;
}

@end
