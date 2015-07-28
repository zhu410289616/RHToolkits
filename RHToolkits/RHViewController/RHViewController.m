//
//  RHViewController.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHViewController.h"

@implementation RHViewController

#pragma mark - is active controller

/**
 *  是否是最上层激活状态的controler
 *
 *  @return yes／no。激活状态为yes，反之为no
 */
- (BOOL)isActiveController
{
    if (self.navigationController.viewControllers.lastObject == self) {
        return YES;
    } else {
        return NO;
    }
}

@end
