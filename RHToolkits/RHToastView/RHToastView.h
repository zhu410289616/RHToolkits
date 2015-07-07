//
//  RHToastView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHToastViewDelegate <NSObject>

- (void)didToastViewHide;

@end

@interface RHToastView : UIView

@property (nonatomic, strong, readonly) UILabel *textLabel;
@property (nonatomic, weak) id<RHToastViewDelegate> delegate;

- (void)showWithMessage:(NSString *)message;
- (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)hide:(BOOL)animated;

@end
