//
//  RHActivityIndicatorView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/22.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHActivityIndicatorView : UIView

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGSize indicatorSize;

@property (nonatomic, assign) NSUInteger replicatorCount;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGFloat fontSize;

- (void)startAnimating;
- (void)stopAnimating;

@end
