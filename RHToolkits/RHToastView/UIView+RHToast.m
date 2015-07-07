//
//  UIView+RHToast.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIView+RHToast.h"
#import <objc/runtime.h>
#import "Masonry.h"

static char rh_toastViewKey;

@implementation UIView (RHToast)

- (RHToastView *)rh_toastView
{
    return objc_getAssociatedObject(self, &rh_toastViewKey);
}

- (void)rh_setToastView:(RHToastView *)toastView
{
    objc_setAssociatedObject(self, &rh_toastViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)rh_checkCreateToast
{
    if ([self rh_toastView]) {
        return;
    }
    RHToastView *toastView = [[RHToastView alloc] init];
    [self rh_setToastView:toastView];
    
    toastView.delegate = self;
    toastView.userInteractionEnabled = YES;
    [self addSubview:toastView];
    [self bringSubviewToFront:toastView];
}

- (void)rh_showToastInTopWithMessage:(NSString *)message
{
    [self rh_checkCreateToast];
    [[self rh_toastView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(50);
        make.width.lessThanOrEqualTo(self);
    }];
    [[self rh_toastView] showWithMessage:message];
}

- (void)rh_showToastInCenterWithMessage:(NSString *)message
{
    [self rh_checkCreateToast];
    [[self rh_toastView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.lessThanOrEqualTo(self);
    }];
    [[self rh_toastView] showWithMessage:message];
}

- (void)rh_showToastInBottomWithMessage:(NSString *)message
{
    [self rh_checkCreateToast];
    [[self rh_toastView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(self);
        make.bottom.equalTo(self).offset(-75);
    }];
    [[self rh_toastView] showWithMessage:message];
}

- (void)rh_hideToast:(BOOL)animated
{
    [[self rh_toastView] hide:animated];
}

#pragma mark -
#pragma mark RHToastViewDelegate method

- (void)didToastViewHide
{
    [[self rh_toastView] removeFromSuperview];
    [self rh_toastView].delegate = nil;
    [self rh_setToastView:nil];
}

@end
