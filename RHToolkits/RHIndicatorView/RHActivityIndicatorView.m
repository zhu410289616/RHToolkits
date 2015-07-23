//
//  RHActivityIndicatorView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/22.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHActivityIndicatorView.h"

static NSString * const kRHLoadingAnimationKey = @"RHLoadingAnimation";

@interface RHActivityIndicatorView ()
{
    CGFloat _duration;
    
    CAReplicatorLayer *_replicatorLayer;
    CALayer *_indicatorLayer;
    CABasicAnimation *_indicatorAnimation;
    
    CATextLayer *_textLayer;
}

@end

@implementation RHActivityIndicatorView

- (void)setup
{
    _duration = 1.0f;
    _indicatorColor = [UIColor greenColor];
    _indicatorSize = CGSizeMake(6, 6);
    _replicatorCount = 10;
    _text = @"Loading";
    _textColor = [UIColor lightGrayColor];
    _fontSize = CGRectGetWidth(self.frame) / 7;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//懒加载，复制层
- (CAReplicatorLayer *)replicator
{
    if (nil == _replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = self.bounds;
        _replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
        // 设置子层次数
        _replicatorLayer.instanceCount = _replicatorCount;
        // 设置子层动画延长时间
        _replicatorLayer.instanceDelay = _duration / MAX(_replicatorCount, 1);
        // 设置子层形变角度
        CGFloat angle = M_PI * 2 / MAX(_replicatorCount, 1);
        _replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    }
    return _replicatorLayer;
}

//普通层
- (CALayer *)indicator
{
    if (nil == _indicatorLayer) {
        _indicatorLayer = [CALayer layer];
        _indicatorLayer.transform = CATransform3DMakeScale(0, 0, 0);
        _indicatorLayer.position = CGPointMake(CGRectGetWidth(self.frame)/2, _indicatorSize.height);
        _indicatorLayer.bounds = CGRectMake(0, 0, _indicatorSize.width, _indicatorSize.height);
        _indicatorLayer.cornerRadius = _indicatorSize.width / 2;
        _indicatorLayer.backgroundColor = _indicatorColor.CGColor;
    }
    return _indicatorLayer;
}

//动画
- (CABasicAnimation *)animation
{
    if (nil == _indicatorAnimation) {
        _indicatorAnimation = [CABasicAnimation animation];
        _indicatorAnimation.keyPath = @"transform.scale";
        _indicatorAnimation.fromValue = @(1);
        _indicatorAnimation.toValue = @(0.1);
        _indicatorAnimation.repeatCount = MAXFLOAT;
        _indicatorAnimation.duration = _duration;
    }
    return _indicatorAnimation;
}

- (CATextLayer *)textIndicatorLayer
{
    if (nil == _textLayer) {
        CGFloat height = _fontSize + 3.0f;
        _textLayer = [CATextLayer layer];
        _textLayer.fontSize = _fontSize;
        _textLayer.frame = CGRectMake(0, (CGRectGetHeight(self.frame)-height)/2, CGRectGetWidth(self.frame), height);
        _textLayer.string = _text;
        _textLayer.alignmentMode = kCAAlignmentCenter;
    }
    return _textLayer;
}

- (void)startAnimating
{
    if (![self.layer.sublayers containsObject:[self replicator]]) {
        //添加复制层
        [self.layer addSublayer:[self replicator]];
        //添加层
        [_replicatorLayer addSublayer:[self indicator]];
        //添加动画
        [_indicatorLayer addAnimation:[self animation] forKey:kRHLoadingAnimationKey];
    }
    if (![self.layer.sublayers containsObject:[self textIndicatorLayer]]) {
        //文字
        [self.layer addSublayer:[self textIndicatorLayer]];
    }
    
    if ([_indicatorLayer animationForKey:kRHLoadingAnimationKey]) {
        return;
    }
    [_indicatorLayer addAnimation:[self animation] forKey:kRHLoadingAnimationKey];
}

- (void)stopAnimating
{
    if ([_indicatorLayer animationForKey:kRHLoadingAnimationKey]) {
        [_indicatorLayer removeAnimationForKey:kRHLoadingAnimationKey];
    }
}

@end
