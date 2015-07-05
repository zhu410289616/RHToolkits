//
//  RHHttpDownloadOperation.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/29.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpCacheOperation.h"

@interface RHHttpDownloadOperation : RHHttpCacheOperation

@property (nonatomic, copy) NSString *cachePath;

- (void)pause;
- (void)resume;
- (void)stop;

@end
