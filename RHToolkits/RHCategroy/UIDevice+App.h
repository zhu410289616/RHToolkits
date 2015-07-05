//
//  UIDevice+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (App)

+ (CGFloat)screenScale;
+ (BOOL)isRetinaScreen;

+ (NSString *)systemVersion;
+ (BOOL)isVersionEqualTo:(NSString *)version;
+ (BOOL)isVersionGreaterThan:(NSString *)version;
+ (BOOL)isVersionGreaterThanOrEqualTo:(NSString *)version;
+ (BOOL)isVersionLessThan:(NSString *)version;
+ (BOOL)isVersionLessThanOrEquealTo:(NSString *)version;

@end
