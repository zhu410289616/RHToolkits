//
//  RHCircularIndicatorView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/23.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHCircularIndicatorView : UIView

@property (nonatomic, assign) CGFloat duration;

- (void)startAnimating;
- (void)stopAnimating;

@end
