//
//  RHMessageCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTableViewCell.h"
#import "UIFont+App.h"
#import "Masonry.h"
#import "RHMessageData.h"

#define kAvatarHeight 45

@interface RHMessageCell : RHTableViewCell

@property (nonatomic, strong, readonly) RHMessageData *messageData;

- (void)updateViewForLeftWithData:(RHMessageData *)cellData;
- (void)updateViewForMiddleWithData:(RHMessageData *)cellData;
- (void)updateViewForRightWithData:(RHMessageData *)cellData;

@end
