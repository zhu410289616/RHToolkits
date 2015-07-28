//
//  RHMapViewManager.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMapViewManager.h"
#import "RHPointAnnotation.h"
#import "RHPolyline.h"

@interface RHMapViewManager () <UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *_doubleTapGesture;
}

@end

@implementation RHMapViewManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _mapView = [[RHMapView alloc] init];
        _mapView.mapType = MAMapTypeStandard;//普通地图
        _mapView.rotateCameraEnabled = NO;
        _mapView.rotateEnabled = NO;
        _mapView.cameraDegree = 0.01f;
        _mapView.delegate = self;
    }
    return self;
}

#pragma mark -
#pragma mark MAMapViewDelegate method

/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    RHMapLog(@"regionWillChangeAnimated...");
    
    //override
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    RHMapLog(@"regionDidChangeAnimated...");
    
    //override
}

/*!
 @brief 地图开始加载
 @param mapview 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView
{
    RHMapLog(@"mapViewWillStartLoadingMap...");
}

/*!
 @brief 地图加载成功
 @param mapView 地图View
 @param dataSize 数据大小
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView dataSize:(NSInteger)dataSize
{
    RHMapLog(@"mapViewDidFinishLoadingMap...%ld", (long)dataSize);
}

/*!
 @brief 地图加载失败
 @param mapView 地图View
 @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error
{
    RHMapLog(@"mapViewDidFailLoadingMap...%@", error.description);
}

/*!
 @brief 根据anntation生成对应的View
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RHPointAnnotation class]]) {
        RHPointAnnotation *rhPointAnnotation = annotation;
        if (rhPointAnnotation.action) {
            return rhPointAnnotation.action((RHMapView *)mapView, rhPointAnnotation);
        }
    }
    return nil;
}

/*!
 @brief 当mapView新添加annotation views时，调用此接口
 @param mapView 地图View
 @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    RHMapLog(@"didAddAnnotationViews...");
}

/*!
 @brief 当选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    RHMapLog(@"didSelectAnnotationView...");
}

/*!
 @brief 当取消选中一个annotation views时，调用此接口
 @param mapView 地图View
 @param views 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    RHMapLog(@"didDeselectAnnotationView...");
}

/*!
 @brief 在地图View将要启动定位时，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    KDMapKitLog(@"mapViewWillStartLocatingUser...");
}

/*!
 @brief 在地图View停止定位后，会调用此函数
 @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    KDMapKitLog(@"mapViewDidStopLocatingUser...");
}

/*!
 @brief 位置或者设备方向更新后，会调用此函数
 @param mapView 地图View
 @param userLocation 用户定位信息(包括位置与设备方向等数据)
 @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //override
}

/*!
 @brief 定位失败后，会调用此函数
 @param mapView 地图View
 @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    //override
}

/*!
 @brief 拖动annotation view时view的状态变化，ios3.2以后支持
 @param mapView 地图View
 @param view annotation view
 @param newState 新状态
 @param oldState 旧状态
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
   fromOldState:(MAAnnotationViewDragState)oldState
{}

/*!
 @brief 根据overlay生成对应的View
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]]) {
        // 定位经纬度圈圈
        return nil;
    } else if ([overlay isKindOfClass:[RHPolyline class]]) {
        RHPolyline *seg = overlay;
        //
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:seg];
        polylineView.lineWidth   = 5.0f;
        polylineView.lineJoinType = kMALineJoinRound;
        polylineView.lineCapType = kMALineCapRound;
        polylineView.strokeColor = [UIColor purpleColor];
        return polylineView;
    }
    
    return nil;
}

/*!
 @brief 当mapView新添加overlay views时，调用此接口
 @param mapView 地图View
 @param overlayViews 新添加的overlay views
 */
- (void)mapView:(MAMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
    RHMapLog(@"didAddOverlayViews...");
}

#pragma mark -
#pragma mark custom gesture listener

- (void)installGestureListener
{
    if (nil == _doubleTapGesture) {
        //移除高德缺省双击手势
        for (UIGestureRecognizer *gestureRecognizer in _mapView.gestureRecognizers) {
            if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)gestureRecognizer;
                if (tapGesture.numberOfTapsRequired > 1) {
                    [_mapView removeGestureRecognizer:gestureRecognizer];
                }//
            }//
        }//for
        _doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTapAction:)];
        _doubleTapGesture.numberOfTouchesRequired = 1;
        _doubleTapGesture.numberOfTapsRequired = 2;
        [_mapView addGestureRecognizer:_doubleTapGesture];
    }
}

/**
 *  双击地图
 *
 *  @param gesture 触发的手势对象
 */
- (void)onDoubleTapAction:(UIGestureRecognizer *)gesture
{
    if (_mapView.zoomLevel >= _mapView.maxZoomLevel) {
        return;
    }
    
    [_mapView setCenterCoordinate:_mapView.centerCoordinate zoomLevel:_mapView.zoomLevel + 1.0f];
}

- (void)uninstallGestureListener
{
    
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate method

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
