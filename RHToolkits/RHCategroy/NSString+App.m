//
//  NSString+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSString+App.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (App)

/**
 *  生成唯一字符串
 *
 *  @return sequence
 */
+ (NSString *)stingWithSequence
{
    //    NSDate *time = [NSDate date];
    //    NSTimeInterval timeInterval = [time timeIntervalSince1970];
    //    return [NSString stringWithFormat:@"%f%d", timeInterval, arc4random()];//arc4random
    return [NSString stringWithFormat:@"%lu", clock()];
}

+ (NSString *)stringByMd5Encode:(NSString *)tString
{
    if(tString && [tString isKindOfClass:[NSString class]]){
        const char *cStr = [tString UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
        
        return [NSString stringWithFormat:
                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }
    return tString;
}

- (NSString *)stringWithMD5Encode
{
    return [NSString stringByMd5Encode:self];
}

/**
 *  对nsdata坐解码，生成nsstring
 *
 *  @param data     data description
 *  @param encoding encoding description
 *
 *  @return return nsstring
 */
+ (NSString *)stringWithData:(NSData *)data encoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:data encoding:encoding];
}

/**
 *  对nsdata坐解码，生成nsstring
 *  default NSUTF8StringEncoding
 *
 *  @param data data description
 *
 *  @return nsstring
 */
+ (NSString *)stringWithData:(NSData *)data
{
    return [NSString stringWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *  格式化时间为字符串
 *
 *  @param tDate      nsdate
 *  @param tFormatter string like @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return string
 */
+ (NSString *)stringWithDate:(NSDate *)tDate formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSString *strTime = [dateformatter stringFromDate:tDate];
    return strTime;
}

/**
 *  格式化时间戳为字符串
 *
 *  @param tTimeInterval 距离1970年的时间戳
 *  @param tFormatter    string like @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return string
 */
+ (NSString *)stringWithTime:(long)tTimeInterval formatter:(NSString *)tFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if (tFormatter) {
        [dateformatter setDateFormat:tFormatter];
    }
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:tTimeInterval];
    NSString *strTime = [dateformatter stringFromDate:tempDate];
    return strTime;
}

/**
 *  url编码
 *
 *  @return string
 */
- (NSString *)stringWithUrlEncode
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
}

/**
 *  url解码
 *
 *  @return string
 */
- (NSString *)stringWithUrlDecode
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  遍历字符串编码格式
 */
- (void)enumStringEncodings
{
    const NSStringEncoding *encodings = [NSString availableStringEncodings];
    NSMutableString *mutableStr = [[NSMutableString alloc] init];
    NSStringEncoding encoding;
    while (0 != (encoding = *encodings++)) {
        [mutableStr appendFormat:@"%@ == %lun", [NSString localizedNameOfStringEncoding:encoding], (unsigned long)encoding];
        NSLog(@"mutableStr: %@", mutableStr);
    }
}

/**
 *  gb2312编码
 *
 *  @return string
 */
- (NSString *)stringWithGB2312Encode
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [[NSString alloc] initWithCString:[self UTF8String] encoding:enc];
}

@end
