//
//  RHMapViewManager.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHMapView.h"

@interface RHMapViewManager : NSObject <MAMapViewDelegate>

@property (nonatomic, strong, readonly) RHMapView *mapView;

+ (instancetype)sharedInstance;

- (void)installGestureListener;
- (void)uninstallGestureListener;

- (void)onDoubleTapAction:(UIGestureRecognizer *)gesture;

@end
