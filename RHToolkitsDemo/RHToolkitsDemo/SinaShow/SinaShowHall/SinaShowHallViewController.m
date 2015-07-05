//
//  SinaShowHallViewController.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "SinaShowHallViewController.h"
#import "SinaShowHallView.h"
#import "SinaShowHallViewAdapter.h"
#import "GetSinaShowRoomList.h"
#import "HallRoomInfo.h"

#import "SinaShowRoomViewController.h"

@interface SinaShowHallViewController () <RHTableViewAdapterDelegate, GetSinaShowRoomListDelegate>
{
    SinaShowHallView *_hallView;
    SinaShowHallViewAdapter *_hallAdapter;
    
    GetSinaShowRoomList *_getRoomList;
}

@end

@implementation SinaShowHallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _hallView = [[SinaShowHallView alloc] init];
    [self.view addSubview:_hallView];
    [_hallView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(self.view);
    }];
    
    //
    _hallAdapter = [[SinaShowHallViewAdapter alloc] init];
    _hallAdapter.delegate = self;
    [_hallView.hallTableView setTableViewAdapter:_hallAdapter];
    
    //
    _getRoomList = [[GetSinaShowRoomList alloc] init];
    _getRoomList.delegate = self;
    [_getRoomList execute];
    
}

#pragma mark -
#pragma mark RHTableViewAdapterDelegate method

- (void)didTableViewCellSelect:(id)cellData
{
    HallRoomInfo *hallInfo = cellData;
    SinaShowRoomViewController *roomController = [[SinaShowRoomViewController alloc] init];
    roomController.roomidx = hallInfo.roomidx;
    [self.navigationController pushViewController:roomController animated:YES];
}

#pragma mark -
#pragma mark GetSinaShowRoomListDelegate method

- (void)didGetSinaShowRoomListSuccess:(id)result
{
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *roomList = result;
        [roomList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HallRoomInfo *room = obj;
            [_hallAdapter addCellData:room];
        }];
        [_hallView.hallTableView reloadData];
    }
}

- (void)didGetSinaShowRoomListFailure:(id)errorInfo
{}

@end
