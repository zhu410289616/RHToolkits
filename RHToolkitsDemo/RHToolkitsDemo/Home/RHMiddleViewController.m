//
//  RHMiddleViewController.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/12.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMiddleViewController.h"
#import "RHMiddleView.h"

#import "NSData+RSA.h"

#import "RHActivityIndicatorView.h"

#import "RHPlayingIndicatorView.h"

#import "RHCircularProgressView.h"
#import "RHCircularIndicatorView.h"

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
    
    //rsa encrypt
    NSString *rsaPublicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSData *rsaPublicKeyData = [NSData dataWithContentsOfFile:rsaPublicKeyPath];
    
    NSString *testStr = @"test ...sfa";
    NSData *testData = [testStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [testData RSAEncryptWithPublicKeyData:rsaPublicKeyData];
    NSLog(@"encryptData: %@", encryptData);
    
    //rsa decrypt
    NSString *rsaPrivateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSData *rsaPrivateKeyData = [NSData dataWithContentsOfFile:rsaPrivateKeyPath];
    
    NSData *decryptData = [encryptData RSADecryptWithPrivateKeyData:rsaPrivateKeyData password:@"123456"];
    NSLog(@"decryptData: %@", decryptData);
    NSLog(@"decrypt string: %@", [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding]);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    RHActivityIndicatorView *indicatorView = [[RHActivityIndicatorView alloc] initWithFrame:CGRectMake(50, 150, 140, 140)];
    [self.view addSubview:indicatorView];
    [indicatorView stopAnimating];
    [indicatorView startAnimating];
    
    indicatorView = [[RHActivityIndicatorView alloc] init];
    indicatorView.center = CGPointMake(150, 300);
    indicatorView.indicatorSize = CGSizeMake(10, 10);
    indicatorView.indicatorColor = [UIColor skyBlueColor];
    [self.view addSubview:indicatorView];
    [indicatorView stopAnimating];
    [indicatorView startAnimating];
    
    
    RHPlayingIndicatorView *playing = [[RHPlayingIndicatorView alloc] init];
    playing.indicatorColor = [UIColor redColor];
    playing.indicatorSize = CGSizeMake(2, 30);
    playing.center = CGPointMake(150, 400);
    [self.view addSubview:playing];
    [playing stopAnimating];
    [playing startAnimating];
    
    playing = [[RHPlayingIndicatorView alloc] initWithFrame:CGRectMake(5, 200, 80, 80)];
    [self.view addSubview:playing];
    [playing stopAnimating];
    [playing startAnimating];
    
    RHCircularIndicatorView *ci = [[RHCircularIndicatorView alloc] init];
    ci.frame = CGRectMake(0, 100, 70, 70);
    [self.view addSubview:ci];
    [ci stopAnimating];
    [ci startAnimating];
    
    RHCircularProgressView *progress = [[RHCircularProgressView alloc] initWithFrame:CGRectMake(0, 200, 60, 60)];
    [self.view addSubview:progress];
    
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
