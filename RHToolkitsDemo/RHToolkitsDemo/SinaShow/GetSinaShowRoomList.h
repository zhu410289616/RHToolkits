//
//  GetSinaShowRoomList.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpGetOperation.h"

@protocol GetSinaShowRoomListDelegate <NSObject>

- (void)didGetSinaShowRoomListSuccess:(id)result;
- (void)didGetSinaShowRoomListFailure:(id)errorInfo;

@end

@interface GetSinaShowRoomList : RHHttpGetOperation

@property (nonatomic, weak) id<GetSinaShowRoomListDelegate> delegate;

@end
