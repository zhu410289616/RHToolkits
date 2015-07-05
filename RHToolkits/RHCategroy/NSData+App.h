//
//  NSData+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (App)

/**
 *  string编码转data
 *
 *  @param tString  tString description
 *  @param encoding encoding description
 *
 *  @return nsstring
 */
+ (NSData *)dataWithString:(NSString *)tString encoding:(NSStringEncoding)encoding;

/**
 *  string编码转data
 *  default NSUTF8StringEncoding
 *
 *  @param tString tString description
 *
 *  @return nsdata
 */
+ (NSData *)dataWithString:(NSString *)tString;

+ (NSData *)dataWithDictionary:(NSDictionary *)dict;

@end
