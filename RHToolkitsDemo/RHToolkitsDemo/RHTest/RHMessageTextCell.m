//
//  RHMessageTextCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageTextCell.h"

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
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}

- (void)updateViewForLeftWithData:(id)cellData
{
    self.contentView.backgroundColor = [UIColor robinEggColor];
    
    self.avatarImageView.backgroundColor = [UIColor emeraldColor];
    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.left.equalTo(self).offset(15.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
    
    _mask.frame = self.avatarImageView.bounds;
    [self.avatarImageView.layer setMask:_mask];
}

- (void)updateViewForMiddleWithData:(id)cellData
{
    self.contentView.backgroundColor = [UIColor limeColor];
    
    self.avatarImageView.backgroundColor = [UIColor oliveColor];
    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
}

- (void)updateViewForRightWithData:(id)cellData
{
    self.contentView.backgroundColor = [UIColor beigeColor];
    
    self.avatarImageView.backgroundColor = [UIColor mudColor];
    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15.0f);
        make.right.equalTo(self).offset(-15.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
}

@end
