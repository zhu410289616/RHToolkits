//
//  RHMessageData.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageData.h"
#import "RHMessageCell.h"

@interface RHMessageData ()

@end

@implementation RHMessageData

- (instancetype)init
{
    if (self = [super init]) {
        _marginTop = 15.0f;
        _marginBotton = 15.0f;
        _nicknameHeight = 0.0f;
    }
    return self;
}

- (RHMessageType)messageType
{
    return RHMessageTypeNone;
}

- (Class)messageCellClass
{
    return [RHMessageCell class];
}

- (RHMessageCellDirection)cellDirection
{
    RHMessageCellDirection direction = RHMessageCellDirectionLeft;
    if ([_fromUserId longLongValue] == [self currentUserId]) {
        direction = RHMessageCellDirectionRight;
    } else {
        direction = RHMessageCellDirectionLeft;
    }
    return direction;
}

- (CGFloat)cellHeight
{
    return 100;
}

#pragma mark -

- (uint64_t)currentUserId
{
    return 1;
}

@end
