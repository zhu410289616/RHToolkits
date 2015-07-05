//
//  RHHttpMultiPostOperation.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpMultiPostOperation.h"

@implementation RHHttpMultiPostOperation

- (NSDictionary *)httpParameters
{
    return nil;
}

- (NSDictionary *)httpMultipartFormDataParameters
{
    return nil;
}

- (RHHttpMethodType)httpMethod
{
    return RHHttpMethodTypeMultiPost;
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
    NSDictionary *multipartFormDataParams = [self httpMultipartFormDataParameters];
    [self doHttpMultiPostWithUrl:url parameters:params multipartFormDataParams:multipartFormDataParams];
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[MULTIPOST] requestSuccess: %@", response);
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"[MULTIPOST] requestFailure: %@", response);
}

- (void)doHttpMultiPostWithUrl:(NSString *)URLString parameters:(NSDictionary *)parameters multipartFormDataParams:(NSDictionary *)multipartFormDataParams
{
    RHHttpLog(@"[MULTI POST] http url: %@, params: %@, multipartFormDataParams: %@", URLString, parameters, multipartFormDataParams);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([self respondsToSelector:@selector(httpRequestSerializer)]) {
        manager.requestSerializer = [self httpRequestSerializer];
    }
    if ([self respondsToSelector:@selector(httpResponseSerializer)]) {
        manager.responseSerializer = [self httpResponseSerializer];
    }
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *multipartParamKeys = [multipartFormDataParams allKeys];
        for (id key in multipartParamKeys) {
            id value = [multipartFormDataParams objectForKey:key];
            if ([value isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:value name:key error:nil];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestSuccess:self response:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailure:self response:error];
    }];
}

@end
