//
//  RHToolItemView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/17.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHToolItemView.h"

@implementation RHToolItemView

- (instancetype)initWithItem:(RHToolItem *)item
{
    if (self = [super init]) {
        
        _itemButtom = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemButtom.tag = item.actionTag;
        [_itemButtom setBackgroundImage:[item.normalImage stretchImageWithInsets:UIEdgeInsetsMake(2, 2, 2, 2)] forState:UIControlStateNormal];
        [_itemButtom setBackgroundImage:[item.highlightImage stretchImageWithInsets:UIEdgeInsetsMake(2, 2, 2, 2)] forState:UIControlStateHighlighted];
        [self addSubview:_itemButtom];
        [_itemButtom mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self).offset(-25);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor robinEggColor];
        _titleLabel.text = item.title;
        [self addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_itemButtom.mas_bottom);
            make.width.equalTo(self);
        }];
        
    }
    return self;
}

@end
