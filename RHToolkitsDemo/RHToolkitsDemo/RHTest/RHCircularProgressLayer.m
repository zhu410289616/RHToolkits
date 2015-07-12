//
//  RHCircularProgressLayer.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCircularProgressLayer.h"

const static float startAngle = M_PI * (-0.5);

@implementation RHCircularProgressLayer

- (void)drawInContext:(CGContextRef)ctx
{
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = width / 2;
    float y = height / 2;
    float outsideRadius = x;
    float innerRadius = x - 5;
    float delta = self.progress * 2 * M_PI;
    
    CGMutablePathRef outsidePath = CGPathCreateMutable();
    CGMutablePathRef innerPath = CGPathCreateMutable();
    
    CGPathAddRelativeArc(outsidePath, 0, x, y, outsideRadius, startAngle, delta);
    CGPathAddLineToPoint(outsidePath, 0, x, y);
    CGPathCloseSubpath(outsidePath);
    
    CGPathAddRelativeArc(innerPath, 0, x, y, innerRadius, startAngle + delta, -delta);
    CGPathAddLineToPoint(innerPath, 0, x, y);
    CGPathCloseSubpath(innerPath);
    
    CGContextAddPath(ctx, outsidePath);
    CGContextAddPath(ctx, innerPath);
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithHex:0x136be2].CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(outsidePath);
    CGPathRelease(innerPath);
}

@end
