//
//  NSDate+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSDate+App.h"

@implementation NSDate (App)

+ (NSDate *)dateWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSDate *date = [dateformatter dateFromString:tDateStr];
    return date;
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)tDateStr formatter:(NSString *)tFormatter
{
    return [[NSDate dateWithString:tDateStr formatter:tFormatter] timeIntervalSince1970];
}

@end
