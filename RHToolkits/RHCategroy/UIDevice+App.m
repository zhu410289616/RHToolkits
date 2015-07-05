//
//  UIDevice+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIDevice+App.h"

@implementation UIDevice (App)

+ (CGFloat)screenScale
{
    CGFloat scale = 1.0f;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }
    return scale;
}

+ (BOOL)isRetinaScreen
{
    CGFloat scale = [self screenScale];
    if (fabs(scale - 2.0f) < FLT_EPSILON) {
        return YES;
    }
    return NO;
}

+ (NSString *)systemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (BOOL)isVersionEqualTo:(NSString *)version
{
    return [[self systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame;
}

+ (BOOL)isVersionGreaterThan:(NSString *)version
{
    return [[self systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending;
}

+ (BOOL)isVersionGreaterThanOrEqualTo:(NSString *)version
{
    return [[self systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)isVersionLessThan:(NSString *)version
{
    return [[self systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending;
}

+ (BOOL)isVersionLessThanOrEquealTo:(NSString *)version
{
    return [[self systemVersion] compare:version options:NSNumericSearch] != NSOrderedDescending;
}

@end
