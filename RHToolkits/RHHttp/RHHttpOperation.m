//
//  RHHttpOperation.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpOperation.h"

@implementation RHHttpOperation

- (NSString *)httpURL
{
    return DEFAULT_HTTP_URL;
}

- (RHHttpMethodType)httpMethod
{
    return RHHttpMethodTypeGet;
}

- (void)execute
{
    RHHttpLog(@"execute...");
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"requestSuccess...");
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"requestFailure...");
}

- (void)main
{
    if ([self respondsToSelector:@selector(willExecute)]) {
        [self willExecute];
    }
    
    [self execute];
    
    if ([self respondsToSelector:@selector(didExecute)]) {
        [self didExecute];
    }
}

@end
