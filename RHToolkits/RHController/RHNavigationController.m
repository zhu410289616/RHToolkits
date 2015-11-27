//
//  RHNavigationController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/11/27.
//  Copyright © 2015年 zhuruhong. All rights reserved.
//

#import "RHNavigationController.h"

@interface RHNavigationController ()
{
    NSMutableArray *_controllers;
}

@end

@implementation RHNavigationController

- (instancetype)init
{
    if (self = [super init]) {
        _controllers = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectedAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [_controllers addObject:viewController];
        _nextController = viewController;
        return;
    }
    
    //pop and clean
    if ([_controllers containsObject:viewController]) {
        [_controllers removeObject:viewController];
    }
    
    [super pushViewController:viewController animated:animated];
    _nextController = nil;//? uncheck
}

#pragma mark - notification

- (void)detectedAppBecomeActive
{
    if (nil == _nextController) {
        return;
    }//if
    
    [self pushViewController:_nextController animated:YES];
}

@end
