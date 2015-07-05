//
//  GetSinaShowRoomList.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "GetSinaShowRoomList.h"
#import "HallRoomInfo.h"

@implementation GetSinaShowRoomList

- (NSString *)httpURL
{
    //return @"http://ok.sina.com.cn/ashx/getlist.ashx";
    return @"http://api.ok.sina.com.cn/phone/getlist.ashx";
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
//    [super requestSuccess:request response:response];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dicRsp = response;
        
        NSArray *tuijianRoomList = [MTLJSONAdapter modelsOfClass:[HallRoomInfo class] fromJSONArray:dicRsp[@"tuijian"] error:nil];
        [tuijianRoomList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HallRoomInfo *room = obj;
            NSLog(@"e: %@(%@), p: %@, hp: %@", room.e, room.roomidx, room.p, room.hp);
        }];
        //
        NSArray *listArray1 = dicRsp[@"list"];
        [listArray1 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dicObj1 = obj;
            NSLog(@"name: %@", dicObj1[@"name"]);
        }];
        
        [_delegate didGetSinaShowRoomListSuccess:tuijianRoomList];
    }
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestFailure:request response:response];
}

@end
