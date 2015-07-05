//
//  RHHeadImageCell.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTableViewCell.h"
#import "TTTAttributedLabel.h"

@interface RHHeadImageCell : RHTableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;

@end
