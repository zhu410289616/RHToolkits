//
//  RHToastView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/7.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHToastView.h"
#import "UIFont+App.h"

@implementation RHToastView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont fontForAppWithSize:14.0f];
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        [_textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)dealloc
{
    RHLogLog(@"[dealloc] RHToastView...");
}

- (void)showWithMessage:(NSString *)message
{
    [self showWithMessage:message duration:1.3f];
}

- (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    _textLabel.text = message;
    [self layoutIfNeeded];
    [self hide:YES afterDelay:duration];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(hideDelayed:) withObject:@(animated) afterDelay:delay];
}

- (void)hideDelayed:(NSNumber *)animated
{
    [self hide:[animated boolValue]];
}

- (void)hide:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    } else {
        [self dismiss];
    }
}

- (void)dismiss
{
    if (_delegate && [_delegate respondsToSelector:@selector(didToastViewHide)]) {
        [_delegate didToastViewHide];
    } else {
        [self removeFromSuperview];
    }
}

@end
