//
//  RHMiddleView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/13.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMiddleView.h"

@implementation RHMiddleView

- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectTalkInputSwitchStateChanged:) name:kNotificationTalkInputSwitchState object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectTalkInputEmojiStateChanged:) name:kNotificationTalkInputEmojiState object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectTalkInputToolStateChanged:) name:kNotificationTalkInputToolState object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectTextViewTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        _inputView = [[RHTalkInputView alloc] init];
        [self addSubview:_inputView];
        [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(@(46));
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark notification

- (void)detectTalkInputSwitchStateChanged:(NSNotification *)notif
{
    RHLogLog(@"detectTalkInputSwitchStateChanged: %@", notif);
    
    NSDictionary *paramDic = notif.object;
    NSInteger endState = [paramDic[@"SwitchEndStateKey"] integerValue];
    if (endState >= 0) {
        [_inputView.inputBar.inputTextView becomeFirstResponder];
//        CGRect frame = _inputView.frame;
//        frame.origin.y -= 258;
//        [UIView animateWithDuration:0.25 animations:^{
//            _inputView.frame = frame;
//        }];
    } else {
        [_inputView.inputBar.inputTextView resignFirstResponder];
//        CGRect frame = _inputView.frame;
//        frame.origin.y += 258;
//        [UIView animateWithDuration:0.25 animations:^{
//            _inputView.frame = frame;
//        }];
    }
}

- (void)detectTalkInputEmojiStateChanged:(NSNotification *)notif
{
    RHLogLog(@"detectTalkInputEmojiStateChanged: %@", notif);
}

- (void)detectTalkInputToolStateChanged:(NSNotification *)notif
{
    RHLogLog(@"detectTalkInputToolStateChanged: %@", notif);
}

- (void)detectKeyboardWillShow:(NSNotification *)notif
{
    RHLogLog(@"detectKeyboardWillShow: %@", notif);
    
    NSDictionary *userInfo = notif.userInfo;
    CGRect beginKeyboardFrame = [userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endKeyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect frame = _inputView.frame;
    frame.origin.y -= CGRectGetHeight(endKeyboardFrame);
    [UIView animateWithDuration:0.5 animations:^{
        _inputView.frame = frame;
    }];
}

- (void)detectKeyboardWillHide:(NSNotification *)notif
{
    RHLogLog(@"detectKeyboardWillHide: %@", notif);
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _inputView.frame;
        frame.origin.y += 258;
        [UIView animateWithDuration:0.5 animations:^{
            _inputView.frame = frame;
        }];
    }];
}

- (void)detectTextViewTextChanged:(NSNotification *)notif
{
    RHLogLog(@"detectTextViewTextChanged: %@", notif);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
