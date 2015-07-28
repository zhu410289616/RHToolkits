//
//  RHMapView.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMapView.h"

@implementation RHMapView

#pragma mark -
#pragma mark region rect

- (void)setDefaultMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated
{
    MACoordinateSpan span = MACoordinateSpanMake(0.02f, 0.02f);
    MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
    [self setRegion:region animated:animated];
}

- (void)setDefaultMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self setDefaultMapRegionWithCoordinate:coordinate animated:YES];
}

- (void)setMapRegionWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count edgePadding:(UIEdgeInsets)edgePadding animated:(BOOL)animated
{
    if (count < 1) {
        return;
    }
    MAPolyline *tempPolyline = [MAPolyline polylineWithCoordinates:coords count:count];
    [self setVisibleMapRect:[tempPolyline boundingMapRect] edgePadding:edgePadding animated:animated];
    if (self.zoomLevel > 16.5f) {
        [self setZoomLevel:16.5f animated:animated];
    }
}

- (void)setMapRegionWithAnnotations:(NSArray *)annotations edgePadding:(UIEdgeInsets)edgePadding animated:(BOOL)animated
{
    if (annotations.count < 1) {
        return;
    }
    NSInteger count = annotations.count;
    MAMapPoint points[count];
    for (NSInteger i=0; i<count; i++) {
        CLLocationCoordinate2D coordinate = [(id<MAAnnotation>)annotations[i] coordinate];
        points[i] = MAMapPointForCoordinate(coordinate);
    }
    MAPolyline *tempPolyline = [MAPolyline polylineWithPoints:points count:count];
    [self setVisibleMapRect:[tempPolyline boundingMapRect] edgePadding:edgePadding animated:animated];
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(CGFloat)zoomLevel
{
    [self setCenterCoordinate:centerCoordinate animated:YES];
    [self setZoomLevel:zoomLevel animated:YES];
}

/**
 *  设置地图的中心点坐标，并根据当前地图的缩放等级调整在制定范围内
 *
 *  @param centerCoordinate 地图中心点坐标
 *  @param minZoomLevel     地图最小校对缩放等级
 *  @param maxZoomLevel     地图最大校对缩放等级
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate minZoomLevel:(CGFloat)minZoomLevel maxZoomLevel:(CGFloat)maxZoomLevel
{
    CGFloat zoomLevel = self.zoomLevel;
    if (zoomLevel < minZoomLevel) {
        zoomLevel = minZoomLevel;
    } else if (zoomLevel > maxZoomLevel) {
        zoomLevel = maxZoomLevel;
    }
    [self setCenterCoordinate:centerCoordinate zoomLevel:zoomLevel];
}

@end
