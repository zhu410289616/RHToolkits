//
//  WebServerView.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "WebServerView.h"

@implementation WebServerView

- (instancetype)init
{
    if (self = [super init]) {
        //
        _tip1Label = [[UILabel alloc] init];
        [self addSubview:_tip1Label];
        
        //
        _tip2Label = [[UILabel alloc] init];
        [self addSubview:_tip2Label];
        
        //
        _tip3Label = [[UILabel alloc] init];
        [self addSubview:_tip3Label];
        
    }
    return self;
}

@end
