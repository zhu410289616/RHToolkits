//
//  UIImage+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIImage+App.h"

@implementation UIImage (App)

//
+ (UIImage *)imageWithColor:(UIColor *)tColor size:(CGSize)tSize
{
    CGRect rect = CGRectMake(0, 0, tSize.width, tSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [tColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//
+ (UIImage *)imageWithName:(NSString *)tName
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tName ofType:@"png"]];
}

+ (UIImage *)imageWithName:(NSString *)tName type:(NSString *)tType
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:tName ofType:tType]];
}

- (UIImage *)stretchImageWithInsets:(UIEdgeInsets)insets
{
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    } else {
        return [self resizableImageWithCapInsets:insets];
    }
}

@end
