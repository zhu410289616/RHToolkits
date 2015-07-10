//
//  RHChatViewAdapter.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHChatViewAdapter.h"
#import "RHMessageTextCell.h"

@implementation RHChatViewAdapter

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RHMessageTextCell class];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
