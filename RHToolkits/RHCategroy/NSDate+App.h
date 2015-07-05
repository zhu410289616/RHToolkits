//
//  NSDate+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (App)

+ (NSDate *)dateWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter;
+ (NSTimeInterval)timeIntervalWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter;

@end
