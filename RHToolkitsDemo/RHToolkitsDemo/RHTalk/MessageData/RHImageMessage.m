//
//  RHImageMessage.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHImageMessage.h"
#import "RHMessageImageCell.h"

@implementation RHImageMessage

- (instancetype)init
{
    if (self = [super init]) {
        _imageUrl = @"http://webimg.9158.com/201410/05/hd1058237261.jpg";
    }
    return self;
}

- (RHMessageType)messageType
{
    return RHMessageTypeImage;
}

- (Class)messageCellClass
{
    return [RHMessageImageCell class];
}

- (CGFloat)cellHeight
{
    //TODO: 需要通过设置控制
    if (RHMessageCellDirectionLeft == [self cellDirection]) {
        self.nicknameHeight = 22.0f;
    } else {
        self.nicknameHeight = 0.0f;
    }
    
    return self.marginTop + self.nicknameHeight + 100 + 12 + self.marginBotton;
}

@end
