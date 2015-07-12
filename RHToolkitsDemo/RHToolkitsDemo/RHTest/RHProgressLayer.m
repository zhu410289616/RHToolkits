//
//  RHProgressLayer.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHProgressLayer.h"

NSString * const kRHProgressKey = @"progress";

@implementation RHProgressLayer

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    return [key isEqualToString:kRHProgressKey];
}

@end
