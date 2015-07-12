//
//  RHMessageImageCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageImageCell.h"
#import "RHImageMessage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RHMessageImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _imageImageView = [[UIImageView alloc] init];
        _imageImageView.userInteractionEnabled = NO;
        [self.bubbleButton addSubview:_imageImageView];
        
        //
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.userInteractionEnabled = NO;
        [self.bubbleButton addSubview:_indicatorView];
        
    }
    return self;
}

- (void)updateViewForLeftWithData:(RHMessageData *)cellData
{
    [super updateViewForLeftWithData:cellData];
    
    RHImageMessage *imageMessage = (RHImageMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(6);
        make.left.equalTo(self.avatarImageView.mas_right).offset(10.0f);
        make.width.equalTo(@(120 + 12 + 7));
        make.height.equalTo(@(100 + 12));
    }];
    
    [_imageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bubbleButton).offset(6);
        make.left.equalTo(self.bubbleButton).offset(13);
        make.width.equalTo(@(120));
        make.height.equalTo(@(100));
    }];
    
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bubbleButton);
    }];
    [_indicatorView startAnimating];
    
    NSURL *url = [NSURL URLWithString:imageMessage.imageUrl];
    [_imageImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            return;
        }
        [_indicatorView stopAnimating];
    }];
}

- (void)updateViewForRightWithData:(RHMessageData *)cellData
{
    [super updateViewForRightWithData:cellData];
    
    RHImageMessage *imageMessage = (RHImageMessage *)cellData;
    
    [self.bubbleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).offset(0);
        make.right.equalTo(self.avatarImageView.mas_left).offset(-10.0f);
        make.width.equalTo(@(120 + 12 + 7));
        make.height.equalTo(@(100 + 12));
    }];
    
    [_imageImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bubbleButton).offset(6);
        make.left.equalTo(self.bubbleButton).offset(7);
        make.width.equalTo(@(120));
        make.height.equalTo(@(100));
    }];
    
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bubbleButton);
    }];
    [_indicatorView startAnimating];
    
    NSURL *url = [NSURL URLWithString:imageMessage.imageUrl];
    [_imageImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            return;
        }
        [_indicatorView stopAnimating];
    }];
}

@end
