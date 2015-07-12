//
//  RHMessageBaseCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageCell.h"
#import "UIImage+App.h"

@interface RHMessageBaseCell : RHMessageCell

@property (nonatomic, strong, readonly) UIImageView *avatarImageView;
@property (nonatomic, strong, readonly) UILabel *nicknameLabel;
@property (nonatomic, strong, readonly) UIButton *bubbleButton;

+ (UIImage *)leftBubbleNormalImage;
+ (UIImage *)leftBubbleSelectedImage;

+ (UIImage *)rightBubbleNormalImage;
+ (UIImage *)rightBubbleSelectedImage;

@end
