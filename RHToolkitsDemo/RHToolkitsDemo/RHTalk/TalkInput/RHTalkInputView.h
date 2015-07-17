//
//  RHTalkInputView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/13.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHTalkInputBar.h"
#import "RHToolView.h"

extern NSString *const kNotificationTalkInputSwitchState;
extern NSString *const kNotificationTalkInputEmojiState;
extern NSString *const kNotificationTalkInputToolState;

@interface RHTalkInputView : UIView <RHTalkInputBarDelegate, RHToolViewDelegate>

@property (nonatomic, strong, readonly) RHTalkInputBar *inputBar;
@property (nonatomic, strong, readonly) RHToolView *toolView;

@end
