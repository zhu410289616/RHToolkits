//
//  RHTalkViewAdapter.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTalkViewAdapter.h"
#import "RHMessageData.h"

@implementation RHTalkViewAdapter

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RHMessageDataProtocol> cellData = self.dataArray[indexPath.row];
    return [cellData messageCellClass];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RHMessageDataProtocol> cellData = self.dataArray[indexPath.row];
    return [cellData cellHeight];
}

@end
