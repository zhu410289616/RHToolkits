//
//  RHLeftViewCell.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLeftViewCell.h"

@implementation RHLeftViewCell

- (void)updateViewWithData:(id)cellData
{
    self.textLabel.text = cellData;
}

@end
