//
//  RHQueue.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHQueueProtocol.h"

@interface RHQueue : NSObject <RHQueueProtocol>

+ (instancetype)sharedInstance;

- (dispatch_queue_t)getQueue;

@end
