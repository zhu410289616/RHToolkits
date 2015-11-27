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

#import "RHRefreshView.h"

#import "UIViewController+MMDrawerController.h"
#import "ViewController.h"
#import "RHTalkViewController.h"
#import "RootViewController.h"

@interface RHLeftViewController () <RHTableViewAdapterDelegate, RHRefreshViewDelegate>
{
    RHLeftView *_leftView;
    RHLeftViewAdapter *_leftAdapter;
    
    RHRefreshView *_headerRefreshView;
    BOOL _reloading;
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
    
    _headerRefreshView = [[RHRefreshView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _leftView.bounds.size.height, kScreenWidth, _leftView.bounds.size.height)];
    _headerRefreshView.delegate = self;
    [_leftView.menuTableView addSubview:_headerRefreshView];
    
    _leftAdapter = [[RHLeftViewAdapter alloc] init];
    _leftAdapter.delegate = self;
    [_leftView.menuTableView setTableViewAdapter:_leftAdapter];
    
    //test data
    [_leftAdapter addCellData:@"talk view"];
    [_leftAdapter addCellData:@"Menu2"];
    [_leftAdapter addCellData:@"Menu3"];
    [_leftAdapter addCellData:@"Menu4"];
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
            ViewController *vc = [[ViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        }
            break;
        case 1: {
            RHTalkViewController *talk = [[RHTalkViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:talk];
            [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
        }
            break;
        case 2: {
            RootViewController *root = [[RootViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
            [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
        }
            break;
            
        default:
            break;
    }//switch
}

- (RHRefreshView *)headerRefreshView
{
    return _headerRefreshView;
}

#pragma mark -
#pragma mark RHRefreshViewDelegate method

- (void)rhRefreshViewDoRefresh:(RHRefreshView *)refreshView
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)rhRefreshViewDataSourceIsLoading:(RHRefreshView *)refreshView
{
    return _reloading;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_headerRefreshView rhRefreshScrollViewDataSourceDidFinishedLoading:_leftView.menuTableView];
    
}

@end
