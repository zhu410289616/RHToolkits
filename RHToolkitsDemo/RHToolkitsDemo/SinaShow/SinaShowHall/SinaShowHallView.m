//
//  SinaShowHallView.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "SinaShowHallView.h"

@implementation SinaShowHallView

- (instancetype)init
{
    if (self = [super init]) {
        _hallTableView = [[RHTableView alloc] init];
        _hallTableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_hallTableView];
        [_hallTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
