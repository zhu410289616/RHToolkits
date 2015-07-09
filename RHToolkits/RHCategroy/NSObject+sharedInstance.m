//
//  NSObject+sharedInstance.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/8.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSObject+sharedInstance.h"

@implementation NSObject (sharedInstance)

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
