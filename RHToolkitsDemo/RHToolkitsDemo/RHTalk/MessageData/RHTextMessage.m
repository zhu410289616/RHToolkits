//
//  RHTextMessage.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTextMessage.h"
#import "UIFont+App.h"
#import "RHMessageTextCell.h"

@implementation RHTextMessage

- (instancetype)init
{
    if (self = [super init]) {
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
    return [RHMessageTextCell class];
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
        return MAX(self.marginTop + self.nicknameHeight + _textHeight + 12 + self.marginBotton, 88.0f);
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_text];
    NSRange allRange = NSMakeRange(0, _text.length);
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontForAppWithSize:15.0f] range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grapeColor] range:allRange];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(kWidthTextMessage, CGFLOAT_MAX) options:options context:nil];
    
    _textWidth = MIN(kWidthTextMessage, rect.size.width) + 3;
    _textHeight = MAX(28, rect.size.height + 3);
    
    return MAX(self.marginTop + self.nicknameHeight + _textHeight + 12 + self.marginBotton, 88.0f);
}

@end
