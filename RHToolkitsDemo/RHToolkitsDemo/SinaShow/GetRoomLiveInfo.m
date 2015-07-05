//
//  GetRoomLiveInfo.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "GetRoomLiveInfo.h"
#import "RoomLiveInfo.h"

@implementation GetRoomLiveInfo

- (instancetype)init
{
    if (self = [super init]) {
        _roomidx = @(9166229);
    }
    return self;
}

- (NSString *)httpURL
{
    return @"http://api.ok.sina.com.cn/phone/GetRoomLiveInfo.ashx";
}

- (NSDictionary *)httpParameters
{
    return @{ @"roomidx":_roomidx };
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestSuccess:request response:response];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dicRsp = response;
        RoomLiveInfo *live = [MTLJSONAdapter modelOfClass:[RoomLiveInfo class] fromJSONDictionary:dicRsp error:nil];
        NSLog(@"roomidx: %@-[%@], livePicurl: %@, video: %@, chat: %@", dicRsp[@"roomidx"], dicRsp[@"welcome"], dicRsp[@"livePicurl"], dicRsp[@"video"], dicRsp[@"chat"]);
        
        [_delegate didGetRoomLiveInfoSuccess:live];
    }
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestFailure:request response:response];
}

@end
