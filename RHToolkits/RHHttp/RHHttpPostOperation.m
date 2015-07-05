//
//  RHHttpPostOperation.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpPostOperation.h"

@implementation RHHttpPostOperation

- (NSDictionary *)httpParameters
{
    return nil;
}

- (RHHttpMethodType)httpMethod
{
    return RHHttpMethodTypePost;
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    return serializer;
}

- (AFHTTPResponseSerializer *)httpResponseSerializer
{
    AFHTTPResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    return serializer;
}

- (void)execute
{
    NSString *url = [self httpURL];
    NSDictionary *params = [self httpParameters];
    [self doHttpPostWithUrl:url parameters:params];
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[POST] requestSuccess: %@", response);
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[POST] requestFailure: %@", response);
}

- (void)doHttpPostWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    RHHttpLog(@"[POST] http url: %@, params: %@", URLString, parameters);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([self respondsToSelector:@selector(httpRequestSerializer)]) {
        manager.requestSerializer = [self httpRequestSerializer];
    }
    if ([self respondsToSelector:@selector(httpResponseSerializer)]) {
        manager.responseSerializer = [self httpResponseSerializer];
    }
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestSuccess:self response:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailure:self response:error];
    }];
}

@end
