//
//  RHPlayingIndicatorView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/23.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHPlayingIndicatorView : UIView

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGSize indicatorSize;

@property (nonatomic, assign) NSUInteger replicatorCount;

- (void)startAnimating;
- (void)stopAnimating;

@end
