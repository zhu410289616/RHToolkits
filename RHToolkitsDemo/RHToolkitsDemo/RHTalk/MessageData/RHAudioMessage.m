//
//  RHAudioMessage.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHAudioMessage.h"
#import "RHMessageAudioCell.h"

@implementation RHAudioMessage

- (instancetype)init
{
    if (self = [super init]) {
        _audioUrl = @"";
    }
    return self;
}

- (RHMessageType)messageType
{
    return RHMessageTypeText;
}

- (Class)messageCellClass
{
    return [RHMessageAudioCell class];
}

- (CGFloat)cellHeight
{
    //TODO: 需要通过设置控制
    if (RHMessageCellDirectionLeft == [self cellDirection]) {
        self.nicknameHeight = 22.0f;
    } else {
        self.nicknameHeight = 0.0f;
    }
    
    return MAX(self.marginTop + self.nicknameHeight + 40 + self.marginBotton, 75.0f);
}

@end
