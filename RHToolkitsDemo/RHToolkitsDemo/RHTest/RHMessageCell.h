//
//  RHMessageCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTableViewCell.h"
#import "RHMessageData.h"

@interface RHMessageCell : RHTableViewCell

@property (nonatomic, strong, readonly) UIImageView *avatarImageView;
@property (nonatomic, strong, readonly) UILabel *nicknameLabel;

- (void)updateViewForLeftWithData:(id)cellData;
- (void)updateViewForMiddleWithData:(id)cellData;
- (void)updateViewForRightWithData:(id)cellData;

@end
