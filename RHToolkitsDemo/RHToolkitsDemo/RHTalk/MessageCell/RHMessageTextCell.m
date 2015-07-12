//
//  RHMessageTextCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageTextCell.h"
#import "RHTextMessage.h"

@implementation RHMessageTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _mask = [CALayer layer];
        _mask.contents = (id)[UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(25, 45)].CGImage;
        
        //
        _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _contentLabel.userInteractionEnabled = NO;
        _contentLabel.font = [UIFont fontForAppWithSize:15.0f];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
        
    }
    return self;
}

- (void)updateViewForLeftWithData:(RHMessageData *)cellData
{
    [super updateViewForLeftWithData:cellData];
    
    RHTextMessage *textMessage = (RHTextMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(6);
        make.left.equalTo(self.avatarImageView.mas_right).offset(10.0f);
        make.width.equalTo(@(textMessage.textWidth + 12 + 8));
        make.height.equalTo(@(textMessage.textHeight + 12));
    }];
    
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bubbleButton).offset(6);
        make.left.equalTo(self.bubbleButton).offset(14);
        make.width.equalTo(@(textMessage.textWidth));
        make.height.equalTo(@(textMessage.textHeight));
    }];
    
    _contentLabel.text = textMessage.text;
}

- (void)updateViewForRightWithData:(RHMessageData *)cellData
{
    [super updateViewForRightWithData:cellData];
    
    RHTextMessage *textMessage = (RHTextMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(0);
        make.right.equalTo(self.avatarImageView.mas_left).offset(-10.0f);
        make.width.equalTo(@(textMessage.textWidth + 12 + 8));
        make.height.equalTo(@(textMessage.textHeight + 12));
    }];
    
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bubbleButton).offset(6);
        make.left.equalTo(self.bubbleButton).offset(8);
        make.width.equalTo(@(textMessage.textWidth));
        make.height.equalTo(@(textMessage.textHeight));
    }];
    
    _contentLabel.text = textMessage.text;
}

@end
