//
//  RHMessageCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageCell.h"
#import "Masonry.h"

@implementation RHMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImageView];
        
        //
        _nicknameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nicknameLabel];
        
    }
    return self;
}

- (void)updateViewWithData:(id)cellData
{
    RHMessageData *messageData = cellData;
    
    switch (messageData.cellDirection) {
        case RHMessageCellDirectionLeft: {
            [self updateViewForLeftWithData:cellData];
            break;
        }
        case RHMessageCellDirectionMiddle: {
            [self updateViewForMiddleWithData:cellData];
            break;
        }
        case RHMessageCellDirectionRight: {
            [self updateViewForRightWithData:cellData];
            break;
        }
        default: {
            break;
        }
    }//switch
}

- (void)updateViewForLeftWithData:(id)cellData
{
    //override
}

- (void)updateViewForMiddleWithData:(id)cellData
{
    //override
}

- (void)updateViewForRightWithData:(id)cellData
{
    //override
}

@end
