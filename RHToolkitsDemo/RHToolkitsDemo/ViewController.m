//
//  ViewController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "ViewController.h"
#import "UIView+RHToast.h"
#import "UIView+RHLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view rh_showToastInBottomWithMessage:@"test toast..."];
    
    [self.view rh_showLoadingWithMessage:@"史蒂夫开始的看法开始地方就是看对方是打开方式扩大防守上的开发商看对方深刻的方式扩大福建省地方上课的飞机库萨发觉我陪哦为哦分"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
