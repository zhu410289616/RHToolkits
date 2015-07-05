//
//  RHHttpProtocol.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/25.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHHttpConfig.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, RHHttpMethodType) {
    RHHttpMethodTypeGet = 0,
    RHHttpMethodTypePost = 1,
    RHHttpMethodTypeMultiPost = 2,
    RHHttpMethodTypeDownload = 3,
    RHHttpMethodTypeUpload = 4,
    RHHttpMethodTypeUnknown
};

@protocol RHHttpProtocol <NSObject>

@required

/**
 *  获取http的请求地址
 *
 *  @return url 字符串
 */
- (NSString *)httpURL;

/**
 *  获取http的请求方式[GET, POST, MULTIPOST]
 *
 *  @return FFHttpMethodType:[RHHttpMethodTypeGet, RHHttpMethodTypePost, RHHttpMethodTypeMultiPost]
 */
- (RHHttpMethodType)httpMethod;

/**
 *  执行请求(设置该方法，主要是可以不依赖NSOperation)
 */
- (void)execute;

/**
 *  请求成功回调
 *
 *  @param request  当前请求对象
 *  @param response 请求结果
 */
- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response;

/**
 *  请求失败回调
 *
 *  @param request  当前请求对象
 *  @param response 请求结果
 */
- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response;

@optional

/**
 *  获取http的请求参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)httpParameters;

/**
 *  获取http的文件数据参数
 *
 *  @return 字典类型的key=value
 */
- (NSDictionary *)httpMultipartFormDataParameters;

- (void)willExecute;
- (void)didExecute;

- (AFHTTPRequestSerializer *)httpRequestSerializer;
- (AFHTTPResponseSerializer *)httpResponseSerializer;

// cache
- (BOOL)shouldWriteResponseToCache;
- (BOOL)shouldReadCacheForResponse;
- (NSString *)keyForCache;
- (void)requestCache:(id<RHHttpProtocol>)request response:(id)response;

// download
- (void)requestDownload:(id<RHHttpProtocol>)request progress:(NSDictionary *)progress;

@end
