//
//  RHTalkInputBar.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/17.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RHSwitchState) {
    RHSwitchStateOpen = 100,
    RHSwitchStateClose = 200
};

@protocol RHTalkInputBarDelegate <NSObject>

- (void)didSwitchButtonAction:(id)object;
- (void)didEmojiButtonAction:(id)object;
- (void)didToolButtonAction:(id)object;

@end

@interface RHTalkInputBar : UIView

@property (nonatomic, strong, readonly) UIButton *switchButton;
@property (nonatomic, strong, readonly) UITextView *inputTextView;
@property (nonatomic, strong, readonly) UIButton *emojiButton;
@property (nonatomic, strong, readonly) UIButton *toolButton;

@property (nonatomic, weak) id<RHTalkInputBarDelegate> delegate;

- (void)updateViewWithData:(id)data;

@end
