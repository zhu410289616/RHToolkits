//
//  SinaShowRoomViewController.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "SinaShowRoomViewController.h"
#import "SinaShowRoomView.h"
#import "GetRoomLiveInfo.h"
#import "RoomLiveInfo.h"

#if TARGET_IPHONE_SIMULATOR
#else
#import "KxMovieViewController.h"
#endif

@interface SinaShowRoomViewController () <GetRoomLiveInfoDelegate>
{
    SinaShowRoomView *_roomView;
    
    GetRoomLiveInfo *_getLiveInfo;
    RoomLiveInfo *_liveInfo;
}

@end

@implementation SinaShowRoomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _roomView = [[SinaShowRoomView alloc] init];
    [self.view addSubview:_roomView];
    [_roomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(self.view);
    }];
    
    //
    _getLiveInfo = [[GetRoomLiveInfo alloc] init];
    _getLiveInfo.delegate = self;
    _getLiveInfo.roomidx = _roomidx;
    [_getLiveInfo execute];
    
}

#pragma mark -
#pragma mark GetRoomLiveInfoDelegate method

- (void)didGetRoomLiveInfoSuccess:(id)result
{
    _liveInfo = result;
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",_liveInfo.video, _liveInfo.roomidx, _liveInfo.liveid];
    NSLog(@"path: %@", path);
    
#if TARGET_IPHONE_SIMULATOR
    //
#else
    KxMovieViewController *movieController = [KxMovieViewController movieViewControllerWithContentPath:path parameters:nil];
    [self presentViewController:movieController animated:YES completion:nil];
#endif
}

- (void)didGetRoomLiveInfoFailure:(id)errorInfo
{}

@end
