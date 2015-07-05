//
//  UIFont+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (App)

+ (void)showAllFont;

+ (UIFont *)fontForAppWithSize:(CGFloat)size;
+ (UIFont *)fontForAppBoldWithSize:(CGFloat)size;

@end
