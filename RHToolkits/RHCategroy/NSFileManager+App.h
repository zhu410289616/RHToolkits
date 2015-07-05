//
//  NSFileManager+App.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (App)

+ (NSString *)pathWithFilePath:(NSString *)filepath;
+ (NSString *)directoryInUserDomain:(NSSearchPathDirectory)directory;
+ (NSString *)cacheDirectory;
+ (NSString *)documentDirectory;
+ (unsigned long long)fileSizeWithFilePath:(NSString *)filepath;
+ (unsigned long long)fileSizeWithDirectory:(NSString *)directory;

@end
