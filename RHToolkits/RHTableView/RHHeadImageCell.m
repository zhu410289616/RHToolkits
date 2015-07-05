//
//  RHHeadImageCell.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHeadImageCell.h"

@implementation RHHeadImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        _titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
