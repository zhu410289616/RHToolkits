//
//  RHLeftViewAdapter.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLeftViewAdapter.h"
#import "RHLeftViewCell.h"

@implementation RHLeftViewAdapter

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RHLeftViewCell class];
}

@end
