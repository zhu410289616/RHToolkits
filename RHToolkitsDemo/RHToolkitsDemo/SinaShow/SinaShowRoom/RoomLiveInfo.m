//
//  RoomLiveInfo.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RoomLiveInfo.h"

@implementation RoomLiveInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"roomidx":@"roomidx",
             @"liveid":@"liveid",
             @"vrootid":@"vrootid",
             @"livePicurl":@"livePicurl",
             @"video":@"video",
             @"chat":@"chat",
             @"status":@"status",
             @"property":@"property",
             @"version":@"version",
             @"uip":@"uip",
             @"report":@"report",
             @"welcome":@"welcome"
             };
}

@end
