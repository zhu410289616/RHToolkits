//
//  NSFileManager+App.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSFileManager+App.h"

@implementation NSFileManager (App)

+ (NSString *)pathWithFilePath:(NSString *)filepath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filepath isDirectory:NULL]) {
        return filepath;
    }
    [fm createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil];
    return filepath;
}

+ (NSString *)directoryInUserDomain:(NSSearchPathDirectory)directory
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *dir = [directories[0] stringByAppendingPathComponent:[NSProcessInfo processInfo].processName];
    return [self pathWithFilePath:dir];
}

+ (NSString *)cacheDirectory
{
    return [self directoryInUserDomain:NSCachesDirectory];
}

+ (NSString *)documentDirectory
{
    return [self directoryInUserDomain:NSDocumentDirectory];
}

+ (unsigned long long)fileSizeWithFilePath:(NSString *)filepath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filepath isDirectory:NULL]) {
        NSDictionary *fileAttributes = [fm attributesOfItemAtPath:filepath error:nil];
        return [fileAttributes fileSize];
    }
    return 0;
}

+ (unsigned long long)fileSizeWithDirectory:(NSString *)directory
{
    return 0;
}

@end
