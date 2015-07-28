//
//  RHCircularRefreshView.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/24.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHRefreshView.h"

@interface RHRefreshIndicatorView : UIView

@property (nonatomic, assign) CGFloat heightBeginToRefresh;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) BOOL isRefreshViewOnTableView;//

- (void)startAnimating;
- (void)stopAnimating;

@end

@interface RHCircularRefreshView : RHRefreshView

@end
