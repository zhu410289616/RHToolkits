//
//  RHLeftViewController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLeftViewController.h"
#import "Masonry.h"
#import "RHLeftView.h"
#import "RHLeftViewAdapter.h"

#import "UIViewController+MMDrawerController.h"
#import "RHTalkViewController.h"
#import "SinaShowHallViewController.h"

@interface RHLeftViewController () <RHTableViewAdapterDelegate>
{
    RHLeftView *_leftView;
    RHLeftViewAdapter *_leftAdapter;
}

@end

@implementation RHLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Left";
    
    _leftView = [[RHLeftView alloc] init];
    [self.view addSubview:_leftView];
    [_leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _leftAdapter = [[RHLeftViewAdapter alloc] init];
    _leftAdapter.delegate = self;
    [_leftView.menuTableView setTableViewAdapter:_leftAdapter];
    
    //test data
    [_leftAdapter addCellData:@"talk view"];
    [_leftAdapter addCellData:@"Menu2"];
    [_leftAdapter addCellData:@"Menu3"];
    [_leftView.menuTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark RHTableViewAdapterDelegate method

- (void)didTableViewSelectIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            SinaShowHallViewController *hall = [[SinaShowHallViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:hall];
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        }
            break;
        case 1: {
            RHTalkViewController *talk = [[RHTalkViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:talk];
            [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
        }
            break;
            
        default:
            break;
    }//switch
}

@end
