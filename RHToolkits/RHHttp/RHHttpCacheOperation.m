//
//  RHHttpCacheOperation.m
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpCacheOperation.h"
#import "NSString+App.h"
#import "EGOCache.h"

@interface RHHttpCacheOperation ()
{
    NSString *_cacheKey;
}

@end

@implementation RHHttpCacheOperation

- (void)willExecute
{
    if ([self shouldReadCacheForResponse]) {
        NSString *key = [self keyForCache];
        if ([[EGOCache globalCache] hasCacheForKey:key]) {
            NSData *data = [[EGOCache globalCache] dataForKey:key];
            [self requestCache:self response:data];
        }
    }
}

- (BOOL)shouldWriteResponseToCache
{
    return NO;
}

- (BOOL)shouldReadCacheForResponse
{
    return NO;
}

- (NSString *)keyForCache
{
    if (_cacheKey.length > 0) {
        return _cacheKey;
    }
    
    NSMutableString *keyMutableString = [[NSMutableString alloc] init];
    
    [keyMutableString appendString:[self httpURL]];
    
    if ([self respondsToSelector:@selector(httpParameters)]) {
        NSDictionary *params = [self httpParameters];
        NSArray *allKeys = [params allKeys];
        NSArray *sortedAllKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        [sortedAllKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *keyValue = [NSString stringWithFormat:@"%@%@", obj, params[obj]];
            [keyMutableString appendString:keyValue];
        }];
    }
    _cacheKey = [NSString stringByMd5Encode:[keyMutableString lowercaseString]];
    return _cacheKey;
}

- (void)requestCache:(id<RHHttpProtocol>)request response:(id)response
{
    RHHttpLog(@"requestCache...");
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestSuccess:request response:response];
    if ([self shouldWriteResponseToCache]) {
        NSString *key = [self keyForCache];
        if ([response isKindOfClass:[NSData class]]) {
            [[EGOCache globalCache] setData:response forKey:key];
        } else if ([response isKindOfClass:[NSString class]]) {
            [[EGOCache globalCache] setString:response forKey:key];
        }
    }
}

@end
