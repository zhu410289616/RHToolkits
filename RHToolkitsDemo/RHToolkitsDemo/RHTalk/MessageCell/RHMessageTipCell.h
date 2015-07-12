//
//  RHMessageTipCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageCell.h"

@interface RHMessageTipCell : RHMessageCell

@property (nonatomic, strong, readonly) UIImageView *bgImageView;
@property (nonatomic, strong, readonly) UILabel *tipLabel;

+ (UIImage *)tipBgImage;

@end
