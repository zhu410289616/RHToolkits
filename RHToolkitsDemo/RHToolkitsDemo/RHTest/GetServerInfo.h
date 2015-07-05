//
//  GetServerInfo.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpGetOperation.h"

@interface GetServerInfo : RHHttpGetOperation

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger toId;
@property (nonatomic, assign) int platformId;

@end
