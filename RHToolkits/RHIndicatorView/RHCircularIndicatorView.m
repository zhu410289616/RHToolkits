//
//  RHCircularIndicatorView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/23.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCircularIndicatorView.h"
#import "RHCircularProgressLayer.h"

@interface RHCircularIndicatorView ()
{
    CAKeyframeAnimation *_keyframeAnimation;
}

@end

@implementation RHCircularIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _duration = 30;
    }
    return self;
}

+ (Class)layerClass
{
    return [RHCircularProgressLayer class];
}

- (CAKeyframeAnimation *)keyframeAnimation
{
    if (nil == _keyframeAnimation) {
        _keyframeAnimation = [CAKeyframeAnimation animation];
        _keyframeAnimation.keyTimes = @[@0, @1];
        _keyframeAnimation.values =   @[@0, @1];
        _keyframeAnimation.timingFunctions = @[
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                                               ];
        _keyframeAnimation.duration = _duration;
        _keyframeAnimation.repeatCount = MAXFLOAT;
        _keyframeAnimation.fillMode = kCAFillModeForwards;
    }
    return _keyframeAnimation;
}

- (void)startAnimating
{
    RHCircularProgressLayer *progressLayer = (RHCircularProgressLayer *)[self layer];
    if ([progressLayer animationForKey:kRHProgressKey]) {
        return;
    }
    [progressLayer addAnimation:[self keyframeAnimation] forKey:kRHProgressKey];
}

- (void)stopAnimating
{
    RHCircularProgressLayer *progressLayer = (RHCircularProgressLayer *)[self layer];
    if ([progressLayer animationForKey:kRHProgressKey]) {
        [progressLayer removeAnimationForKey:kRHProgressKey];
    }
}

@end
