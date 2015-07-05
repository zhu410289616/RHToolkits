//
//  SinaShowHallViewAdapter.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "SinaShowHallViewAdapter.h"
#import "SinaShowHallCell.h"

@implementation SinaShowHallViewAdapter

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SinaShowHallCell class];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
