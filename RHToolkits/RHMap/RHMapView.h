//
//  RHMapView.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface RHMapView : MAMapView

#pragma mark -
#pragma mark region rect

- (void)setDefaultMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;
- (void)setDefaultMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)setMapRegionWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count edgePadding:(UIEdgeInsets)edgePadding animated:(BOOL)animated;
- (void)setMapRegionWithAnnotations:(NSArray *)annotations edgePadding:(UIEdgeInsets)edgePadding animated:(BOOL)animated;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(CGFloat)zoomLevel;

/**
 *  设置地图的中心点坐标，并根据当前地图的缩放等级调整在制定范围内
 *
 *  @param centerCoordinate 地图中心点坐标
 *  @param minZoomLevel     地图最小校对缩放等级
 *  @param maxZoomLevel     地图最大校对缩放等级
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate minZoomLevel:(CGFloat)minZoomLevel maxZoomLevel:(CGFloat)maxZoomLevel;

@end
