//
//  RHToolItemView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/17.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHToolItem.h"

@interface RHToolItemView : UIView

@property (nonatomic, strong, readonly) UIButton *itemButtom;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

- (instancetype)initWithItem:(RHToolItem *)item;

@end
