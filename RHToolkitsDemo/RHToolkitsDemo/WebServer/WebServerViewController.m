//
//  WebServerViewController.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "WebServerViewController.h"
#import "WebServerView.h"
#import "NSFileManager+App.h"
#import "GCDWebUploader.h"

@interface WebServerViewController () <GCDWebUploaderDelegate>
{
    WebServerView *_webServerView;
    GCDWebUploader *_webServer;
}

@end

@implementation WebServerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _webServerView = [[WebServerView alloc] init];
    [self.view addSubview:_webServerView];
    [_webServerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(self.view);
    }];
    
    //
    NSString *documentDir = [NSFileManager documentDirectory];
    NSString *webServerPath = [NSFileManager pathWithFilePath:[NSString stringWithFormat:@"%@/WebServer", documentDir]];
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:webServerPath];
    _webServer.delegate = self;
    if ([_webServer startWithPort:20144 bonjourName:@"RH"]) {
        NSLog(@"Web Server Url: %@", _webServer.serverURL.absoluteString);
    };
    
}

#pragma mark -
#pragma mark GCDWebUploaderDelegate method

/**
 *  This method is called whenever a file has been downloaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDownloadFileAtPath:(NSString*)path
{
    NSLog(@"[DOWNLOAD] %@", path);
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path
{
    NSLog(@"[UPLOAD] %@", path);
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath
{
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path
{
    NSLog(@"[DELETE] %@", path);
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path
{
    NSLog(@"[CREATE] %@", path);
}

@end
