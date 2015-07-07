//
//  UIView+RHToast.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHToastView.h"

@interface UIView (RHToast) <RHToastViewDelegate>

- (RHToastView *)rh_toastView;

- (void)rh_showToastInTopWithMessage:(NSString *)message;
- (void)rh_showToastInCenterWithMessage:(NSString *)message;
- (void)rh_showToastInBottomWithMessage:(NSString *)message;
- (void)rh_hideToast:(BOOL)animated;

@end
