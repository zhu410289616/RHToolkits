//
//  RHMessageImageCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageImageCell.h"

@implementation RHMessageImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //
        _imageImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageImageView];
        
        //
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        [self.contentView addSubview:_indicatorView];
        
    }
    return self;
}

@end
