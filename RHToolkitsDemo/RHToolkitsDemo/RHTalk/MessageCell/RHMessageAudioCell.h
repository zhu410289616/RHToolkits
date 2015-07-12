//
//  RHMessageAudioCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageBaseCell.h"

@interface RHMessageAudioCell : RHMessageBaseCell

@property (nonatomic, strong, readonly) UIButton *audioButton;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong, readonly) UILabel *durationLabel;

@end
