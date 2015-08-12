//
//  UIViewController+App.h
//  Way
//
//  Created by zhuruhong on 15/8/4.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (App)

- (UIBarButtonItem *)backBarButtonItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)backBarButtonItem;
- (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)leftBarButtonItem;
- (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)rightBarButtonItem;

- (void)doBackBarButtonAction;
- (void)doLeftBarButtonAction;
- (void)doRightBarButtonAction;

@end
