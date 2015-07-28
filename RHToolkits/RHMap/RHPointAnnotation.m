//
//  RHPointAnnotation.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHPointAnnotation.h"
#import "RHMapConfig.h"

@implementation RHPointAnnotation

- (void)setConstructAction:(MAAnnotationView *(^)(RHMapView *, RHPointAnnotation *))action
{
    _action = action;
}

- (void)dealloc
{
    _annotationView = nil;
    _action = nil;
    RHMapLog(@"[dealloc] RHPointAnnotation...");
}

@end
