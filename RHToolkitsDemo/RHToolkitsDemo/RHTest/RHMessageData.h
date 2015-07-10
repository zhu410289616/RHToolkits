//
//  RHMessageData.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RHMessageCellDirection) {
    RHMessageCellDirectionLeft = 0,
    RHMessageCellDirectionMiddle = 1,
    RHMessageCellDirectionRight = 2
};

@protocol RHMessageDataProtocol <NSObject>

@property (nonatomic, assign, readonly) RHMessageCellDirection cellDirection;

@end

@interface RHMessageData : NSObject <RHMessageDataProtocol>

@property (nonatomic, strong) NSData *blobdata;

@end
