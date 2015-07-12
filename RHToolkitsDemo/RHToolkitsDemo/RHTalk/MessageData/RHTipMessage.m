//
//  RHTipMessage.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTipMessage.h"
#import "RHMessageTipCell.h"

@implementation RHTipMessage

- (instancetype)init
{
    if (self = [super init]) {
        self.marginTop = 6.0f;
        self.marginBotton = 6.0f;
        self.nicknameHeight = 0.0f;
        _textHeight = -1;
        _text = @"sdfksdfjse23时的开发建设的会计考试地方设立开放式地方 看到福建省地方";
    }
    return self;
}

- (RHMessageType)messageType
{
    return RHMessageTypeText;
}

- (Class)messageCellClass
{
    return [RHMessageTipCell class];
}

- (RHMessageCellDirection)cellDirection
{
    return RHMessageCellDirectionMiddle;
}

- (CGFloat)cellHeight
{
    //TODO: 需要通过设置控制
    if (RHMessageCellDirectionLeft == [self cellDirection]) {
        self.nicknameHeight = 22.0f;
    } else {
        self.nicknameHeight = 0.0f;
    }
    
    if (_textHeight >= 0) {
        return MAX(self.marginTop + _textHeight + self.marginBotton, 46.0f);
    }
    
    CGFloat tipMaxWidth = 220;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_text];
    NSRange allRange = NSMakeRange(0, _text.length);
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontForAppWithSize:13.0f] range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grapeColor] range:allRange];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(tipMaxWidth, CGFLOAT_MAX) options:options context:nil];
    
    _textWidth = MIN(tipMaxWidth, rect.size.width) + 3;
    _textHeight = MAX(20, rect.size.height + 3);
    
    return MAX(self.marginTop + _textHeight + self.marginBotton, 44.0f);
}

@end
