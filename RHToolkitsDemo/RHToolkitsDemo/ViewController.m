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

#import "RHChatView.h"
#import "RHChatViewAdapter.h"
#import "RHMessageData.h"

@interface ViewController ()
{
    RHStretchTableView *_stretchTableView;
    
    RHChatView *_chatView;
    RHChatViewAdapter *_chatAdapter;
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
//    _stretchTableView = [[RHStretchTableView alloc] init];
//    [self.view addSubview:_stretchTableView];
//    [_stretchTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.equalTo(self.view);
//    }];
    
    
    _chatView = [[RHChatView alloc] init];
    [self.view addSubview:_chatView];
    [_chatView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _chatAdapter = [[RHChatViewAdapter alloc] init];
    [_chatView.chatTableView setTableViewAdapter:_chatAdapter];
    
    for (int i=0; i<50; i++) {
        RHMessageData *message = [[RHMessageData alloc] init];
        [_chatAdapter addCellData:message];
    }
    [_chatView.chatTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
