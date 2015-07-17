//
//  RHMiddleViewController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMiddleViewController.h"
#import "RHMiddleView.h"

@interface RHMiddleViewController ()
{
    RHMiddleView *_middleView;
}

@end

@implementation RHMiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Middle";
    
    _middleView = [[RHMiddleView alloc] init];
    [self.view addSubview:_middleView];
    [_middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
