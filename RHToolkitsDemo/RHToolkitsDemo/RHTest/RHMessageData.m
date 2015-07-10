//
//  RHMessageData.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMessageData.h"

@implementation RHMessageData

- (RHMessageCellDirection)cellDirection
{
    RHMessageCellDirection direction = RHMessageCellDirectionLeft;
    
    //TODO: 测试方向
    int test = rand() % 3;
    if (test == 0) {
        direction = RHMessageCellDirectionLeft;
    } else if (test == 1) {
        direction = RHMessageCellDirectionMiddle;
    } else if (test == 2) {
        direction = RHMessageCellDirectionRight;
    }
    
    return direction;
}

@end
