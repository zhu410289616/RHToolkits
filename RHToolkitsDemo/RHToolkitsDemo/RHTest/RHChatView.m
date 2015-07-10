//
//  RHChatView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHChatView.h"

@implementation RHChatView

- (instancetype)init
{
    if (self = [super init]) {
        _chatTableView = [[RHTableView alloc] init];
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_chatTableView];
        [_chatTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    return self;
}

@end
