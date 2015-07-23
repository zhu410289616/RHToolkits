//
//  RHCircularProgressLayer.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString * const kRHProgressKey;

@interface RHCircularProgressLayer : CALayer

@property (assign) float progress;

- (CGColorRef)progressColor;

@end
