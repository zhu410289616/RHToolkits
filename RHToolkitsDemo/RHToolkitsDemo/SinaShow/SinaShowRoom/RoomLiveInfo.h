//
//  RoomLiveInfo.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface RoomLiveInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *roomidx;
@property (nonatomic, copy) NSString *liveid;
@property (nonatomic, copy) NSString *vrootid;
@property (nonatomic, copy) NSString *livePicurl;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *chat;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *property;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *uip;
@property (nonatomic, strong) NSNumber *report;
@property (nonatomic, copy) NSString *welcome;

@end
