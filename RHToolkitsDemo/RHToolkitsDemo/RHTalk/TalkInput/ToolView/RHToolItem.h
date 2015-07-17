//
//  RHToolItem.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/15.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHToolItem : NSObject

@property (nonatomic, assign) NSInteger actionTag;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightImage;
@property (nonatomic, copy) NSString *title;

@end
