//
//  RHTalkInputBar.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/17.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTalkInputBar.h"

@implementation RHTalkInputBar

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        //
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton setImage:[UIImage imageNamed:@"talk_btn_voice"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"talk_btn_voice_on"] forState:UIControlStateHighlighted];
        [_switchButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [_switchButton addTarget:self action:@selector(doSwitchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_switchButton];
        [_switchButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(69, 46));
        }];
        
        //
        _toolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toolButton setImage:[UIImage imageNamed:@"talk_btn_more"] forState:UIControlStateNormal];
        [_toolButton setImage:[UIImage imageNamed:@"talk_btn_more_on"] forState:UIControlStateHighlighted];
        [_toolButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [_toolButton addTarget:self action:@selector(doToolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_toolButton];
        [_toolButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_switchButton);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 46));
        }];
        
        //
        _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emojiButton setImage:[UIImage imageNamed:@"talk_btn_emoji"] forState:UIControlStateNormal];
        [_emojiButton setImage:[UIImage imageNamed:@"talk_btn_emoji_on"] forState:UIControlStateHighlighted];
        [_emojiButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [_emojiButton addTarget:self action:@selector(doEmojiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_emojiButton];
        [_emojiButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_toolButton);
            make.right.equalTo(_toolButton.mas_left);
            make.size.mas_equalTo(CGSizeMake(46, 46));
        }];
        
        //
        _inputTextView = [[UITextView alloc] init];
        [self addSubview:_inputTextView];
        [_inputTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_switchButton.mas_right);
            make.right.equalTo(_emojiButton.mas_left);
            make.bottom.equalTo(self);
            make.height.equalTo(@(46));
        }];
        
    }
    return self;
}

- (void)doSwitchButtonAction:(id)sender
{
    UIButton *button = sender;
    NSInteger beginState = button.tag;
    NSInteger endState = -1;
    if (beginState >= 0) {
        endState = -1;
    } else {
        endState = 1;
    }
    button.tag = endState;
    NSDictionary *paramDic = @{@"SwitchBeginStateKey":@(beginState),@"SwitchEndStateKey":@(endState)};
    if ([_delegate respondsToSelector:@selector(didSwitchButtonAction:)]) {
        [_delegate didSwitchButtonAction:paramDic];
    }
}

- (void)doEmojiButtonAction:(id)sender
{
    UIButton *button = sender;
    NSInteger beginState = button.tag;
    NSInteger endState = -1;
    if (beginState >= 0) {
        endState = -1;
    } else {
        endState = 1;
    }
    button.tag = endState;
    NSDictionary *paramDic = @{@"EmojiBeginStateKey":@(beginState),@"EmojiEndStateKey":@(endState)};
    if ([_delegate respondsToSelector:@selector(didEmojiButtonAction:)]) {
        [_delegate didEmojiButtonAction:paramDic];
    }
}

- (void)doToolButtonAction:(id)sender
{
    UIButton *button = sender;
    NSInteger beginState = button.tag;
    NSInteger endState = -1;
    if (beginState >= 0) {
        endState = -1;
    } else {
        endState = 1;
    }
    button.tag = endState;
    NSDictionary *paramDic = @{@"ToolBeginStateKey":@(beginState),@"ToolEndStateKey":@(endState)};
    if ([_delegate respondsToSelector:@selector(didToolButtonAction:)]) {
        [_delegate didToolButtonAction:paramDic];
    }
}

- (void)updateViewWithData:(id)data
{}

@end
