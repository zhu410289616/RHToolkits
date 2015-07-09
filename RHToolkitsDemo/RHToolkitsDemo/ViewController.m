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

#import "RHStretchTableView.h"
#import "Masonry.h"

@interface ViewController ()
{
    RHStretchTableView *_stretchTableView;
}

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
    
    //
    [self.view rh_showToastInBottomWithMessage:@"test toast..."];
    
    //
    [self.view rh_showLoadingWithMessage:@"史蒂夫开始的看法开始地方就是看对方是打开方式扩大防守上的开发商看对方深刻的方式扩大福建省地方上课的飞机库萨发觉我陪哦为哦分"];
    
    //
    UIView *fixedHeaderView = [[UIView alloc] init];
    fixedHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160);
    fixedHeaderView.backgroundColor = [UIColor clearColor];
//    [fixedHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view);
//        make.height.equalTo(@(160));
//    }];
    
    UIView *avatarView = [[UIView alloc] init];
    avatarView.backgroundColor = [UIColor paleGreenColor];
    [fixedHeaderView addSubview:avatarView];
    [avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(fixedHeaderView);
        make.size.mas_equalTo(CGSizeMake(40, 100));
    }];
    
    //
    UIView *stretchView = [[UIView alloc] init];
    stretchView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    stretchView.backgroundColor = [UIColor limeColor];
    
    _stretchTableView = [[RHStretchTableView alloc] init];
    [self.view addSubview:_stretchTableView];
    [_stretchTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
