//
//  RHLeftView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLeftView.h"

@implementation RHLeftView

- (instancetype)init
{
    if (self = [super init]) {
        _menuTableView = [[RHTableView alloc] init];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_menuTableView];
        [_menuTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    return self;
}

@end
