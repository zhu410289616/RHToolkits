//
//  RHTalkView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTalkView.h"

@implementation RHTalkView

- (instancetype)init
{
    if (self = [super init]) {
        _talkTableView = [[RHTableView alloc] init];
        _talkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talkTableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_talkTableView];
        [_talkTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    return self;
}

@end
