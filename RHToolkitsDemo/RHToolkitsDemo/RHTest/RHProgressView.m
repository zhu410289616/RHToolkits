//
//  RHProgressView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHProgressView.h"
#import "RHCircularProgressLayer.h"

@implementation RHProgressView

+ (Class)layerClass
{
    return [RHCircularProgressLayer class];
}

- (void)updateProgress:(float)progress
{
    RHCircularProgressLayer *progressLayer = (RHCircularProgressLayer *)[self layer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue = @0;
    animation.toValue = @50;
    animation.duration = 20;
    animation.fillMode = kCAFillModeForwards;
    
    CAKeyframeAnimation *anime = [CAKeyframeAnimation animation];
    anime.keyTimes = @[@0, @1];
    anime.values =   @[@0, @1];
    anime.timingFunctions = @[
                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                              ];
    anime.duration = 30;
    anime.fillMode = kCAFillModeForwards;
//    anime.repeatCount = NSIntegerMax;//
    
//        [progressLayer addAnimation:anime forKey:kRHProgressKey];
    
    progressLayer.progress = progress;
    [progressLayer setNeedsDisplay];
}

@end
