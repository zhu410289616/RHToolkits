//
//  UIImage+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (App)

+ (UIImage *)imageWithColor:(UIColor *)tColor size:(CGSize)tSize;

+ (UIImage *)imageWithName:(NSString *)tName;
+ (UIImage *)imageWithName:(NSString *)tName type:(NSString *)tType;

- (UIImage *)stretchImageWithInsets:(UIEdgeInsets)insets;

@end
