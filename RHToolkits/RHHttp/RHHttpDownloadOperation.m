//
//  RHHttpDownloadOperation.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpDownloadOperation.h"
#import "NSFileManager+App.h"
#import "EXTScope.h"
#import "EGOCache.h"

@interface RHHttpDownloadOperation ()
{
    NSString *_cachePath;
    unsigned long long _offset;
    NSString *_range;
    AFHTTPRequestOperation *_operation;
}

@end

@implementation RHHttpDownloadOperation

- (NSDictionary *)httpParameters
{
    return nil;
}

- (RHHttpMethodType)httpMethod
{
    return RHHttpMethodTypeDownload;
}

- (NSString *)pathForCache
{
    if (_cachePath.length > 0) {
        return _cachePath;
    }
    _cachePath = [NSString stringWithFormat:@"%@/%@", [NSFileManager cacheDirectory], [self keyForCache]];
    return _cachePath;
}

- (NSString *)keyForFileSize
{
    return [NSString stringWithFormat:@"%@-size", [self keyForCache]];
}

- (void)willExecute
{
    _offset = [NSFileManager fileSizeWithFilePath:[self pathForCache]];
    NSString *fileSizeKey = [self keyForFileSize];
    if ([[EGOCache globalCache] hasCacheForKey:fileSizeKey]) {
        NSString *fileSize = [[EGOCache globalCache] stringForKey:fileSizeKey];
        _range = [NSString stringWithFormat:@"bytes=%llu-%@", _offset, fileSize];
    } else {
        _range = [NSString stringWithFormat:@"bytes=%llu-", _offset];
    }
}

- (void)execute
{
    NSString *url = [self httpURL];
    NSDictionary *params = [self httpParameters];
    [self doHttpDownloadWithUrl:url parameters:params];
}

- (void)requestDownload:(id<RHHttpProtocol>)request progress:(NSDictionary *)progress
{
    RHHttpLog(@"[DOWNLOAD] requestDownload: %@", progress);
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[DOWNLOAD] requestSuccess: %@", response);
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[DOWNLOAD] requestFailure: %@", response);
}

- (void)doHttpDownloadWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    RHHttpLog(@"[DOWNLOAD] http url: %@, params: %@", URLString, parameters);
    
    NSURL *url = [NSURL URLWithString:[self httpURL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:_range forHTTPHeaderField:@"Range"];
    
    @weakify(self);
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    _operation.outputStream = [[NSOutputStream alloc] initToFileAtPath:_cachePath append:YES];
    [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        @strongify(self);
        [[EGOCache globalCache] setString:[NSString stringWithFormat:@"%lld", totalBytesRead] forKey:[self keyForFileSize]];
        
        NSDictionary *progress = @{
                                   @"bytesRead":@(bytesRead),
                                   @"totalBytesRead":@(totalBytesRead),
                                   @"totalBytesExpectedToRead":@(totalBytesExpectedToRead)
                                   };
        [self requestDownload:self progress:progress];
    }];
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self);
        NSDictionary *result = @{ @"FilePath":[self pathForCache] };
        [self requestSuccess:self response:result];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @strongify(self);
        NSDictionary *result = @{ @"FilePath":[self pathForCache] };
        [self requestSuccess:self response:result];
    }];
    [_operation start];
}

- (void)pause
{
    [_operation pause];
}

- (void)resume
{
    [_operation resume];
}

- (void)stop
{
    [_operation cancel];
}

@end
