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
