//
//  UIFont+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (void)showAllFont
{
    NSArray *familyNames = [UIFont familyNames];
    for (id obj in familyNames) {
        NSLog(@"obj: %@", obj);
    }
}

+ (UIFont *)fontForAppWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)fontForAppBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end
