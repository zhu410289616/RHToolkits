//
//  UIViewController+App.m
//  Way
//
//  Created by zhuruhong on 15/8/4.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "UIViewController+App.h"

@implementation UIViewController (App)

- (instancetype)init
{
    if (self = [super init]) {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (UIBarButtonItem *)backBarButtonItemWithTitle:(NSString *)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doBackBarButtonAction)];
    return item;
}

- (UIBarButtonItem *)backBarButtonItem
{
    return [self backBarButtonItemWithTitle:@"back1"];
}

- (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doLeftBarButtonAction)];
    return item;
}

- (UIBarButtonItem *)leftBarButtonItem
{
    return [self leftBarButtonItemWithTitle:@"left"];
}

- (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonAction)];
    return item;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    return [self rightBarButtonItemWithTitle:@"right"];
}

- (void)doBackBarButtonAction
{
    RHLogLog(@"doBackBarButtonAction...");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doLeftBarButtonAction
{
    RHLogLog(@"doLeftBarButtonAction...");
}

- (void)doRightBarButtonAction
{
    RHLogLog(@"doRightBarButtonAction...");
}

@end
