//
//  RHRefreshView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/24.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHRefreshView.h"
#import "Masonry.h"

@interface RHRefreshView ()
{
    UIActivityIndicatorView *_indicatorView;
    UILabel *_statusLabel;
    RHPullRefreshState _state;
}

@end

@implementation RHRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
        }];
        [_indicatorView startAnimating];
        
        //
        _statusLabel = [[UILabel alloc] init];
        [self addSubview:_statusLabel];
        [_statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_indicatorView.mas_right);
        }];
        
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
        if ([_delegate respondsToSelector:@selector(rhRefreshViewDataSourceIsLoading:)]) {
            isLoading = [_delegate rhRefreshViewDataSourceIsLoading:self];
        }//if
        if (RHPullRefreshStatePulling == _state && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !isLoading) {
            [self setState:RHPullRefreshStateNormal];
        } else if (RHPullRefreshStateNormal == _state && scrollView.contentOffset.y < -65.0f && !isLoading) {
            [self setState:RHPullRefreshStatePulling];
        }//if
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }//if
    }
}

- (void)rhRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    BOOL isLoading = NO;
    if ([_delegate respondsToSelector:@selector(rhRefreshViewDataSourceIsLoading:)]) {
        isLoading = [_delegate rhRefreshViewDataSourceIsLoading:self];
    }
    if (scrollView.contentOffset.y <= -65.0f && !isLoading) {
        if ([_delegate respondsToSelector:@selector(rhRefreshViewDoRefresh:)]) {
            [_delegate rhRefreshViewDoRefresh:self];
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
    }];
    [self setState:RHPullRefreshStateNormal];
}

@end
