//
//  RHMessageAudioCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageAudioCell.h"
#import "RHAudioMessage.h"

@implementation RHMessageAudioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _audioButton.backgroundColor = [UIColor tealColor];
        [self.bubbleButton addSubview:_audioButton];
        
        //
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.userInteractionEnabled = NO;
        [self.bubbleButton addSubview:_indicatorView];
        
        //
        _durationLabel = [[UILabel alloc] init];
        [self.bubbleButton addSubview:_durationLabel];
        
    }
    return self;
}

- (void)updateViewForLeftWithData:(RHMessageData *)cellData
{
    [super updateViewForLeftWithData:cellData];
    
    RHAudioMessage *audioMessage = (RHAudioMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(6);
        make.left.equalTo(self.avatarImageView.mas_right).offset(10.0f);
        make.width.equalTo(@(120 + 12 + 7));
        make.height.equalTo(@(40));
    }];
    
    [_audioButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bubbleButton);
        make.left.equalTo(self.bubbleButton).offset(14);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bubbleButton);
    }];
    [_indicatorView startAnimating];
    
}

- (void)updateViewForRightWithData:(RHMessageData *)cellData
{
    [super updateViewForRightWithData:cellData];
    
    RHAudioMessage *audioMessage = (RHAudioMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(0);
        make.right.equalTo(self.avatarImageView.mas_left).offset(-10.0f);
        make.width.equalTo(@(120 + 12 + 7));
        make.height.equalTo(@(40));
    }];
    
    [_audioButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bubbleButton);
        make.left.equalTo(self.bubbleButton).offset(8);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bubbleButton);
    }];
    [_indicatorView startAnimating];
    
}

@end
