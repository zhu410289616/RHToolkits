//
//  NSData+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSData+App.h"

@implementation NSData (App)

/**
 *  string编码转data
 *
 *  @param tString  tString description
 *  @param encoding encoding description
 *
 *  @return nsstring
 */
+ (NSData *)dataWithString:(NSString *)tString encoding:(NSStringEncoding)encoding
{
    return [tString dataUsingEncoding:encoding];
}

/**
 *  string编码转data
 *  default NSUTF8StringEncoding
 *
 *  @param tString tString description
 *
 *  @return nsdata
 */
+ (NSData *)dataWithString:(NSString *)tString
{
    return [tString dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData *)dataWithDictionary:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    if (error) {
        NSLog(@"Unable to serialize JSON object with error: %@", error.description);
        return nil;
    }
    return jsonData;
}

@end
