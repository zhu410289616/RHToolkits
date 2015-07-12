//
//  RHTalkViewController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHTalkViewController.h"
#import "Masonry.h"
#import "RHTalkView.h"
#import "RHTalkViewAdapter.h"

#import "RHTextMessage.h"
#import "RHImageMessage.h"
#import "RHTipMessage.h"
#import "RHAudioMessage.h"

@interface RHTalkViewController ()
{
    RHTalkView *_talkView;
    RHTalkViewAdapter *_talkAdapter;
}

@end

@implementation RHTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _talkView = [[RHTalkView alloc] init];
    [self.view addSubview:_talkView];
    [_talkView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _talkAdapter = [[RHTalkViewAdapter alloc] init];
    [_talkView.talkTableView setTableViewAdapter:_talkAdapter];
    
    //
    [self testTalkView];
    
}

- (void)testTalkView
{
    RHImageMessage *imageMessage = [[RHImageMessage alloc] init];
    imageMessage.fromUserId = @(234);
    imageMessage.fromAvatarUrl = @"http://webimg.9158.com/201507/05/04194285.jpg";
    [_talkAdapter addCellData:imageMessage];
    
    imageMessage = [[RHImageMessage alloc] init];
    imageMessage.fromUserId = @(1);
    imageMessage.fromAvatarUrl = @"http://webimg.9158.com/201507/03/05314187.jpg";
    [_talkAdapter addCellData:imageMessage];
    
    RHTipMessage *tipMessage = [[RHTipMessage alloc] init];
    [_talkAdapter addCellData:tipMessage];
    
    tipMessage = [[RHTipMessage alloc] init];
    tipMessage.text = @"4🎡dsf水电费";
    [_talkAdapter addCellData:tipMessage];
    
    RHAudioMessage *audioMessage = [[RHAudioMessage alloc] init];
    audioMessage.fromUserId = @(1);
    audioMessage.audioUrl = @"http://webimg.9158.com/201410/05/hd1058237261.jpg";
    [_talkAdapter addCellData:audioMessage];
    
    audioMessage = [[RHAudioMessage alloc] init];
    audioMessage.fromUserId = @(12);
    audioMessage.audioUrl = @"http://webimg.9158.com/201410/05/hd1058237261.jpg";
    [_talkAdapter addCellData:audioMessage];
    
    for (int i=0; i<50; i++) {
        RHTextMessage *message = [[RHTextMessage alloc] init];
        message.fromUserId = @(i % 3);
        NSMutableString *test = [[NSMutableString alloc] initWithFormat:@"%@", @"sdfksdfjse23时方 看地方"];
        for (int j=0; j<i; j++) {
            [test appendFormat:@"哈哈😄水电费"];
        }
        message.text = [test substringFromIndex:0];
        [_talkAdapter addCellData:message];
    }
    
    [_talkView.talkTableView reloadData];
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
