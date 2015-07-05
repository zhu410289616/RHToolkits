//
//  RHViewController.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/27.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHViewController : UIViewController

/**
 *  是否是最上层激活状态的controler
 *
 *  @return yes／no。激活状态为yes，反之为no
 */
- (BOOL)isActiveController;

@end
