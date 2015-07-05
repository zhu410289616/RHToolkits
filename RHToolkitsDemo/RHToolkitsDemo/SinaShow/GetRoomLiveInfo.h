//
//  GetRoomLiveInfo.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpGetOperation.h"

@protocol GetRoomLiveInfoDelegate <NSObject>

- (void)didGetRoomLiveInfoSuccess:(id)result;
- (void)didGetRoomLiveInfoFailure:(id)errorInfo;

@end

@interface GetRoomLiveInfo : RHHttpGetOperation

@property (nonatomic, strong) NSNumber *roomidx;
@property (nonatomic, weak) id<GetRoomLiveInfoDelegate> delegate;

@end
