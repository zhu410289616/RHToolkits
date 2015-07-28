//
//  RHPointAnnotation.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>

@class RHMapView;
@class RHPointAnnotation;

typedef MAAnnotationView *(^RHAnnotationViewConstruct)(RHMapView *mapView, RHPointAnnotation *annotation);

@interface RHPointAnnotation : MAPointAnnotation

@property (nonatomic, strong) MAAnnotationView *annotationView;
@property (nonatomic, copy) RHAnnotationViewConstruct action;

- (void)setConstructAction:(MAAnnotationView *(^)(RHMapView *mapView, RHPointAnnotation *annotation))action;

@end
