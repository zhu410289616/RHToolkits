//
//  UIView+RHLoading.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (RHLoading) <MBProgressHUDDelegate>

- (MBProgressHUD *)rh_HUDView;

#pragma mark -
#pragma mark determinate function

//- (void)rh_showWithLabelDeterminate:(NSString *)label;
//- (void)rh_showWithLabelAnnularDeterminate:(NSString *)label;

#pragma mark -
#pragma mark horizontal bar function

//- (void)rh_showWithLabelDeterminateHorizontalBar;

#pragma mark -
#pragma mark loading function

- (void)rh_showLoadingWithMessage:(NSString *)message;
- (void)rh_showLoadingWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)rh_showLoadingWithTitle:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration;
- (void)rh_hideLoading:(BOOL)animated;

@end
