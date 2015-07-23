//
//  RHPlayingIndicatorView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/23.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHPlayingIndicatorView.h"

static NSString * const kRHPlayingAnimationKey = @"RHPlayingAnimation";

@interface RHPlayingIndicatorView ()
{
    CAReplicatorLayer *_replicatorLayer;
    CALayer *_indicatorLayer;
    CABasicAnimation *_basicAnimation;
}

@end

@implementation RHPlayingIndicatorView

- (void)setup
{
    _indicatorColor = [UIColor greenColor];
    _indicatorSize = CGSizeMake(6, 18);
    _replicatorCount = 4;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (CAReplicatorLayer *)replicator
{
    if (_replicatorLayer == nil) {
        CGFloat tx = 10;
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = self.bounds;
        // 设置4个子层，3个复制层
        _replicatorLayer.instanceCount = _replicatorCount;
        // 设置复制子层的相对位置，每个x轴相差tx
        _replicatorLayer.instanceTransform = CATransform3DMakeTranslation(tx, 0, 0);
        // 设置复制子层的延迟动画时长
        _replicatorLayer.instanceDelay = 0.3;
    }
    return _replicatorLayer;
}

- (CALayer *)indicator
{
    if (_indicatorLayer == nil) {
        _indicatorLayer = [CALayer layer];
        _indicatorLayer.backgroundColor = _indicatorColor.CGColor;
        _indicatorLayer.bounds = CGRectMake(0, 0, _indicatorSize.width, _indicatorSize.height);
        _indicatorLayer.anchorPoint = CGPointMake(0, 1);
    }
    return _indicatorLayer;
}

- (CABasicAnimation *)animation
{
    if (_basicAnimation == nil) {
        _basicAnimation = [CABasicAnimation animation];
        _basicAnimation.keyPath = @"transform.scale.y";
        _basicAnimation.toValue = @(0.1);
        _basicAnimation.autoreverses = YES;
        _basicAnimation.repeatCount = MAXFLOAT;
        
    }
    return _basicAnimation;
}

- (void)startAnimating
{
    if (![self.layer.sublayers containsObject:[self replicator]]) {
        //添加复制层
        [self.layer addSublayer:[self replicator]];
        //添加层
        [_replicatorLayer addSublayer:[self indicator]];
        //添加动画
        [_indicatorLayer addAnimation:[self animation] forKey:kRHPlayingAnimationKey];
    }
    
    if ([_indicatorLayer animationForKey:kRHPlayingAnimationKey]) {
        return;
    }
    [_indicatorLayer addAnimation:[self animation] forKey:kRHPlayingAnimationKey];
}

- (void)stopAnimating
{
    if ([_indicatorLayer animationForKey:kRHPlayingAnimationKey]) {
        [_indicatorLayer removeAnimationForKey:kRHPlayingAnimationKey];
    }
}

@end
