//
//  RHToolView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/15.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHToolViewDelegate <NSObject>

@required

- (void)didItemButtonAction:(id)sender;

@end

@interface RHToolView : UIView

@property (nonatomic, weak) id<RHToolViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items;

@end
