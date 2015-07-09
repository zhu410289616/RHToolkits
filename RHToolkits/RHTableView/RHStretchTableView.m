//
//  RHStretchTableView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/9.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHStretchTableView.h"

@interface RHStretchTableView ()
{
    UIView *_fixedHeaderView;
    UIView *_stretchView;
}

@end

@implementation RHStretchTableView

- (instancetype)init
{
    if (self = [super init]) {
        
        //
        _fixedHeaderView = [self fixedHeaderView];
        _fixedHeaderView.backgroundColor = [UIColor clearColor];
        //
        _stretchView = [self stretchView];
        
        //
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:_fixedHeaderView.bounds];
        self.tableHeaderView = tableHeaderView;
        
        //
        UIView *stretchMaskView = [[UIView alloc] initWithFrame:_stretchView.bounds];
        CGRect stretchMaskViewFrame = stretchMaskView.frame;
        stretchMaskViewFrame.origin.y = CGRectGetHeight(tableHeaderView.frame) - CGRectGetHeight(stretchMaskViewFrame);
        stretchMaskView.frame = stretchMaskViewFrame;
        stretchMaskView.clipsToBounds = YES;
        [tableHeaderView addSubview:stretchMaskView];
        
        //
        CGRect stretchViewFrame = _stretchView.frame;
        stretchViewFrame.origin.y = (CGRectGetHeight(stretchViewFrame) - CGRectGetHeight(tableHeaderView.frame))/2;
        _stretchView.frame = stretchViewFrame;
        [stretchMaskView addSubview:_stretchView];
        
        
        //
        _fixedHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(_fixedHeaderView.frame), CGRectGetHeight(_fixedHeaderView.frame));
        [tableHeaderView addSubview:_fixedHeaderView];
        
    }
    return self;
}

- (UIView *)fixedHeaderView
{
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = CGRectMake(0, 0, kScreenWidth, 160);
    
    UIView *avatarView = [[UIView alloc] init];
    avatarView.frame = CGRectMake(15, 160 - 45 - 15, 45, 45);
    avatarView.backgroundColor = [UIColor paleGreenColor];
    [tempView addSubview:avatarView];
    
    return tempView;
}

- (UIView *)stretchView
{
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    tempView.backgroundColor = [UIColor limeColor];
    return tempView;
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    if (contentOffset.y <= 0 && contentOffset.y >= -1) {
        contentOffset.y = 0;
    }
    
    [super setContentOffset:contentOffset];
    
    CGFloat offsetY = contentOffset.y;
    if (offsetY <= 0) {
        CGFloat tempOrigionY = (CGRectGetHeight(_stretchView.frame) - (CGRectGetHeight(self.tableHeaderView.frame) - offsetY))/2;
        CGRect stretchViewFrame = _stretchView.frame;
        stretchViewFrame.origin.y = tempOrigionY;
        _stretchView.frame = stretchViewFrame;
    }
}

@end
