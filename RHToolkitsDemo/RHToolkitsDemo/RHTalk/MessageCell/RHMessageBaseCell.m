//
//  RHMessageBaseCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageBaseCell.h"

@implementation RHMessageBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _avatarImageView = [[UIImageView alloc] init];
        [self addSubview:_avatarImageView];
        
        //
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont fontForAppWithSize:15.0f];
        _nicknameLabel.text = @"nick name label ...";
        [self addSubview:_nicknameLabel];
        
        //
        _bubbleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_bubbleButton];
        
    }
    return self;
}

- (void)updateViewForLeftWithData:(RHMessageData *)cellData
{
    [super updateViewForLeftWithData:cellData];
    
    _avatarImageView.backgroundColor = [UIColor emeraldColor];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:cellData.fromAvatarUrl]];
    [_avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.left.equalTo(self).offset(15.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
    
    [_nicknameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.left.equalTo(_avatarImageView.mas_right).offset(10.0f);
        make.right.lessThanOrEqualTo(self);
        make.height.equalTo(@(16.0f));
    }];
    _nicknameLabel.hidden = NO;
    
    [_bubbleButton setBackgroundImage:[RHMessageBaseCell leftBubbleNormalImage] forState:UIControlStateNormal];
    [_bubbleButton setBackgroundImage:[RHMessageBaseCell leftBubbleSelectedImage] forState:UIControlStateHighlighted];
    [_bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nicknameLabel.mas_bottom);
        make.left.equalTo(_avatarImageView.mas_right).offset(10.0f);
        make.width.lessThanOrEqualTo(@(180));
    }];
}

- (void)updateViewForMiddleWithData:(RHMessageData *)cellData
{
    [super updateViewForMiddleWithData:cellData];
    
    _avatarImageView.backgroundColor = [UIColor oliveColor];
    [_avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
}

- (void)updateViewForRightWithData:(RHMessageData *)cellData
{
    [super updateViewForRightWithData:cellData];
    
    _avatarImageView.backgroundColor = [UIColor mudColor];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:cellData.fromAvatarUrl]];
    [_avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
    
    [_nicknameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.left.lessThanOrEqualTo(self);
        make.right.equalTo(_avatarImageView.mas_left).offset(-10.0f);
        make.height.equalTo(@(0.0f));
    }];
    _nicknameLabel.hidden = YES;
    
    [_bubbleButton setBackgroundImage:[RHMessageBaseCell rightBubbleNormalImage] forState:UIControlStateNormal];
    [_bubbleButton setBackgroundImage:[RHMessageBaseCell rightBubbleSelectedImage] forState:UIControlStateHighlighted];
    [_bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nicknameLabel.mas_bottom);
        make.right.equalTo(_avatarImageView.mas_left).offset(-10.0f);
        make.width.lessThanOrEqualTo(@(180));
    }];
}

+ (UIImage *)leftBubbleNormalImage
{
    return [[UIImage imageNamed:@"bubble_left"] stretchImageWithInsets:UIEdgeInsetsMake(27, 19, 11, 12)];
}

+ (UIImage *)leftBubbleSelectedImage
{
    return [[UIImage imageNamed:@"bubble_left_down"] stretchImageWithInsets:UIEdgeInsetsMake(27, 19, 11, 12)];
}

+ (UIImage *)rightBubbleNormalImage
{
    return [[UIImage imageNamed:@"bubble_right"] stretchImageWithInsets:UIEdgeInsetsMake(27, 12, 11, 19)];
}

+ (UIImage *)rightBubbleSelectedImage
{
    return [[UIImage imageNamed:@"bubble_right_down"] stretchImageWithInsets:UIEdgeInsetsMake(27, 12, 11, 19)];
}

@end
