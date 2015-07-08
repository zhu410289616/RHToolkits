//
//  UIView+RHLoading.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIView+RHLoading.h"
#import <objc/runtime.h>
#import "UIColor+App.h"

static char rh_HUDViewKey;

@implementation UIView (RHLoading)

- (MBProgressHUD *)rh_HUDView
{
    return objc_getAssociatedObject(self, &rh_HUDViewKey);
}

- (void)rh_setHUDView:(MBProgressHUD *)HUDView
{
    objc_setAssociatedObject(self, &rh_HUDViewKey, HUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)rh_checkCreateHUD
{
    if ([self rh_HUDView]) {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    [self rh_setHUDView:hud];
    hud.delegate = self;
    
    [self addSubview:hud];
    [self bringSubviewToFront:hud];
}

#pragma mark -
#pragma mark determinate function

- (void)rh_showWithLabelDeterminate:(NSString *)label
{
    [self rh_checkCreateHUD];
    [self rh_HUDView].mode = MBProgressHUDModeDeterminate;
    [self rh_HUDView].labelText = label;
    [[self rh_HUDView] show:YES];
}

- (void)rh_showWithLabelAnnularDeterminate:(NSString *)label
{
    [self rh_checkCreateHUD];
    [self rh_HUDView].mode = MBProgressHUDModeAnnularDeterminate;
    [self rh_HUDView].labelText = label;
    [[self rh_HUDView] show:YES];
}

#pragma mark -
#pragma mark horizontal bar function

- (void)rh_showWithLabelDeterminateHorizontalBar
{
    [self rh_checkCreateHUD];
    [self rh_HUDView].mode = MBProgressHUDModeDeterminateHorizontalBar;
    [[self rh_HUDView] show:YES];
}

#pragma mark -
#pragma mark loading function

- (void)rh_showLoadingWithMessage:(NSString *)message
{
    [self rh_showLoadingWithTitle:nil message:message duration:1.2f];
}

- (void)rh_showLoadingWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self rh_HUDView].backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.5];
    [self rh_showLoadingWithTitle:nil message:message duration:duration];
}

- (void)rh_showLoadingWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration
{
    [self rh_checkCreateHUD];
    [self rh_HUDView].labelText =title;
    [self rh_HUDView].detailsLabelText = message;
    [[self rh_HUDView] show:YES];
    [[self rh_HUDView] hide:YES afterDelay:duration];
}

- (void)rh_hideLoading:(BOOL)animated
{
    [[self rh_HUDView] hide:animated];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate method

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [[self rh_HUDView] removeFromSuperview];
    [self rh_HUDView].delegate = nil;
    [self rh_setHUDView:nil];
}

@end
