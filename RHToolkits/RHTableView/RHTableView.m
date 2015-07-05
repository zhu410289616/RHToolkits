//
//  RHTableView.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTableView.h"

@implementation RHTableView

- (void)setTableViewAdapter:(RHTableViewAdapter *)tableViewAdapter
{
    self.delegate = tableViewAdapter;
    self.dataSource = tableViewAdapter;
}

@end
