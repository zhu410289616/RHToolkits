//
//  RHRefreshView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/24.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//
//  copy from https://github.com/enormego/EGOTableViewPullRefresh

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RHPullRefreshState) {
    RHPullRefreshStateNormal,
    RHPullRefreshStatePulling,
    RHPullRefreshStateLoading,
};

@class RHRefreshView;

@protocol RHRefreshViewDelegate <NSObject>

@required

- (void)rhRefreshViewDoRefresh:(RHRefreshView *)refreshView;
- (BOOL)rhRefreshViewDataSourceIsLoading:(RHRefreshView *)refreshView;

@optional

- (NSDate *)rhRefreshViewDataSourceLastUpdated:(RHRefreshView *)refreshView;

@end

@interface RHRefreshView : UIView

@property (nonatomic, weak) id<RHRefreshViewDelegate> delegate;

- (void)setState:(RHPullRefreshState)state;

- (void)rhRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)rhRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)rhRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

