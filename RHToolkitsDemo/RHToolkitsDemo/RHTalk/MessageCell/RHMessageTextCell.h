//
//  RHMessageTextCell.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageBaseCell.h"
#import "TTTAttributedLabel.h"

@interface RHMessageTextCell : RHMessageBaseCell

@property (nonatomic, strong, readonly) CALayer *mask;

@property (nonatomic, strong, readonly) TTTAttributedLabel *contentLabel;

@end
