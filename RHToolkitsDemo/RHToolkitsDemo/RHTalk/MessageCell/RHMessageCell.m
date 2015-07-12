//
//  RHMessageCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageCell.h"

@implementation RHMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateViewWithData:(id)cellData
{
    _messageData = cellData;
    
    switch (_messageData.cellDirection) {
        case RHMessageCellDirectionLeft: {
            [self updateViewForLeftWithData:_messageData];
            break;
        }
        case RHMessageCellDirectionMiddle: {
            [self updateViewForMiddleWithData:_messageData];
            break;
        }
        case RHMessageCellDirectionRight: {
            [self updateViewForRightWithData:_messageData];
            break;
        }
        default: {
            break;
        }
    }//switch
}

- (void)updateViewForLeftWithData:(RHMessageData *)cellData
{
    self.contentView.backgroundColor = [UIColor robinEggColor];
}

- (void)updateViewForMiddleWithData:(RHMessageData *)cellData
{
    self.contentView.backgroundColor = [UIColor limeColor];
}

- (void)updateViewForRightWithData:(RHMessageData *)cellData
{
    self.contentView.backgroundColor = [UIColor beigeColor];
}

@end
