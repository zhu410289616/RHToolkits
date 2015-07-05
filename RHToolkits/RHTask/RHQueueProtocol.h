//
//  RHQueueProtocol.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHRunnableProtocol.h"

@protocol RHQueueProtocol <NSObject>

@required

- (void)addTask:(id<RHRunnableProtocol>)task;

@end