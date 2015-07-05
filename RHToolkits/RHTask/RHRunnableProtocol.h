//
//  RHRunnableProtocol.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHTaskConfig.h"

@protocol RHRunnableProtocol <NSObject>

@required

- (void)execute;

@end
