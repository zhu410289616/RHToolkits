//
//  RHTalkInputView.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/13.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTalkInputView.h"
#import "RHToolItem.h"

NSString *const kNotificationTalkInputSwitchState = @"kNotificationTalkInputSwitchState";
NSString *const kNotificationTalkInputEmojiState = @"kNotificationTalkInputEmojiState";
NSString *const kNotificationTalkInputToolState = @"kNotificationTalkInputToolState";

@implementation RHTalkInputView

- (instancetype)init
{
    if (self = [super init]) {
        
        //
        _inputBar = [[RHTalkInputBar alloc] init];
        _inputBar.delegate = self;
        [self addSubview:_inputBar];
        [_inputBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(@(46));
        }];
        
        //
        NSMutableArray *itemList = [[NSMutableArray alloc] init];
        for (int i=0; i<15; i++) {
            RHToolItem *item = [[RHToolItem alloc] init];
            item.actionTag = i;
            item.normalImage = [UIImage imageWithColor:[UIColor beigeColor] size:CGSizeMake(10, 10)];
            item.highlightImage = [UIImage imageWithColor:[UIColor dustColor] size:CGSizeMake(10, 10)];
            item.title = [NSString stringWithFormat:@"title %d", i];
            [itemList addObject:item];
        }
        
        _toolView = [[RHToolView alloc] initWithItems:itemList];
        _toolView.delegate = self;
        [self addSubview:_toolView];
        [_toolView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_inputBar.mas_bottom);
            make.width.equalTo(self);
            make.height.equalTo(@(216));
        }];
        
    }
    return self;
}

#pragma mark -
#pragma mark RHTalkInputBarDelegate method

- (void)didSwitchButtonAction:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTalkInputSwitchState object:object];
}

- (void)didEmojiButtonAction:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTalkInputEmojiState object:object];
}

- (void)didToolButtonAction:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTalkInputToolState object:object];
}

#pragma mark -
#pragma mark RHToolViewDelegate method

- (void)didItemButtonAction:(id)sender
{
    UIButton *button = sender;
    RHLogLog(@"didItemButtonAction: %li", (long)button.tag);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
