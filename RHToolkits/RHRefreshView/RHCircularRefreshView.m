//
//  RHCircularRefreshView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/24.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCircularRefreshView.h"

static NSString * const kRHIndicatorAnimationKey = @"RHIndicatorAnimation";

@interface RHRefreshIndicatorView ()
{
    CABasicAnimation *_basicAnimation;
}

@end

@implementation RHRefreshIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _heightBeginToRefresh = 50;
        _offsetY = 0;
    }
    return self;
}

- (CABasicAnimation *)animation
{
    if (_basicAnimation == nil) {
        _basicAnimation = [CABasicAnimation animation];
        _basicAnimation.keyPath = @"transform.rotation.z";
        _basicAnimation.toValue = @(M_PI / 2);
        _basicAnimation.duration = 0.25f;
        _basicAnimation.cumulative = YES;
        _basicAnimation.removedOnCompletion = NO;
        _basicAnimation.fillMode = kCAFillModeForwards;
        _basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _basicAnimation.repeatCount = MAXFLOAT;
    }
    return _basicAnimation;
}

- (void)startAnimating
{
    if ([self.layer animationForKey:kRHIndicatorAnimationKey]) {
        return;
    }
    [self.layer addAnimation:[self animation] forKey:kRHIndicatorAnimationKey];
}

- (void)stopAnimating
{
    if ([self.layer animationForKey:kRHIndicatorAnimationKey]) {
        [self.layer removeAnimationForKey:kRHIndicatorAnimationKey];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1].CGColor);
    CGContextSetLineWidth(context, 1.f);
    
    static CGFloat radius = 9;
    if (_isRefreshViewOnTableView) {
        static CGFloat startAngle = M_PI / 2;
        CGFloat endAngle = (ABS(_offsetY) / _heightBeginToRefresh) * (M_PI * 19 / 10) + startAngle;
        CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);
    } else {
        static CGFloat startAngle = 3 * M_PI / 2;
        CGFloat endAngle = (ABS(_offsetY) / _heightBeginToRefresh) * (M_PI * 19 / 10) + startAngle;
        CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);
    }
    CGContextDrawPath(context, kCGPathStroke);
}

@end

#define HEIGHT_BEGIN_TO_DRAW_CIRCLE 20

@interface RHCircularRefreshView ()
{
    RHRefreshIndicatorView *_indicatorView;
    UILabel *_statusLabel;
    RHPullRefreshState _state;
}

@end

@implementation RHCircularRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //
        _indicatorView = [[RHRefreshIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20) / 2 - 30, (self.frame.size.height - 20) / 2, 20, 20)];
        [self addSubview:_indicatorView];
        
        //
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(_indicatorView.frame.origin.x + _indicatorView.frame.size.width + 5, (self.frame.size.height - 20) / 2, 200, 20)];
        [self addSubview:_statusLabel];
        
        //
        [self setState:RHPullRefreshStateNormal];
        
    }
    return self;
}

- (void)setState:(RHPullRefreshState)state
{
    switch (state) {
        case RHPullRefreshStateNormal: {
            if (RHPullRefreshStatePulling == _state) {
                //
            }
            _statusLabel.text = @"Pull down to refresh...";
            [_indicatorView stopAnimating];
            _indicatorView.offsetY = 0.0f;
            [_indicatorView setNeedsDisplay];
            break;
        }
        case RHPullRefreshStatePulling: {
            _statusLabel.text = @"Release to refresh...";
            break;
        }
        case RHPullRefreshStateLoading: {
            _statusLabel.text = @"Loading...";
            [_indicatorView startAnimating];
            break;
        }
        default: {
            break;
        }
    }//switch
    
    _state = state;
}

#pragma mark -
#pragma mark ScrollView Methods

- (void)rhRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (RHPullRefreshStateLoading == _state) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    } else if (scrollView.isDragging) {
        BOOL isLoading = NO;
        if ([self.delegate respondsToSelector:@selector(rhRefreshViewDataSourceIsLoading:)]) {
            isLoading = [self.delegate rhRefreshViewDataSourceIsLoading:self];
        }//if
        if (RHPullRefreshStatePulling == _state && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !isLoading) {
            [self setState:RHPullRefreshStateNormal];
        } else if (RHPullRefreshStateNormal == _state && scrollView.contentOffset.y < -65.0f && !isLoading) {
            [self setState:RHPullRefreshStatePulling];
            if (ABS(scrollView.contentOffset.y) >= HEIGHT_BEGIN_TO_DRAW_CIRCLE) {
                _indicatorView.offsetY = MIN(ABS(scrollView.contentOffset.y), _indicatorView.heightBeginToRefresh) - HEIGHT_BEGIN_TO_DRAW_CIRCLE;
                [_indicatorView setNeedsDisplay];
            }
        }//if
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }//if
    }
}

- (void)rhRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    BOOL isLoading = NO;
    if ([self.delegate respondsToSelector:@selector(rhRefreshViewDataSourceIsLoading:)]) {
        isLoading = [self.delegate rhRefreshViewDataSourceIsLoading:self];
    }
    if (scrollView.contentOffset.y <= -65.0f && !isLoading) {
        if ([self.delegate respondsToSelector:@selector(rhRefreshViewDoRefresh:)]) {
            [self.delegate rhRefreshViewDoRefresh:self];
        }
        [self setState:RHPullRefreshStateLoading];
        //https://github.com/enormego/EGOTableViewPullRefresh bug
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
            }];
        });
    }
}

- (void)rhRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [self setState:RHPullRefreshStateNormal];
        if (_indicatorView) {
            [_indicatorView stopAnimating];
        }
    }];
}

@end
