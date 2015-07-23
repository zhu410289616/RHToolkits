//
//  RHCircularProgressView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/23.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCircularProgressView.h"
#import "RHCircularProgressLayer.h"

@implementation RHCircularProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.progress = 0.6f;
    }
    return self;
}

+ (Class)layerClass
{
    return [RHCircularProgressLayer class];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self updateProgress:_progress];
}

- (void)updateProgress:(float)progress
{
    RHCircularProgressLayer *progressLayer = (RHCircularProgressLayer *)[self layer];
    progressLayer.progress = progress;
    [progressLayer setNeedsDisplay];
}

@end
