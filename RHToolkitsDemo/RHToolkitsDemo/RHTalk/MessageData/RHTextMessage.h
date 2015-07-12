//
//  RHTextMessage.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageData.h"

#define kWidthTextMessage 180.0f

@interface RHTextMessage : RHMessageData

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign, readonly) CGFloat textWidth;
@property (nonatomic, assign, readonly) CGFloat textHeight;

@end
