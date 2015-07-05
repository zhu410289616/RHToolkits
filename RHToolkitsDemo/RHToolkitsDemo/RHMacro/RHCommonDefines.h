//
//  RHCommonDefines.h
//  RHToolkit
//
//  Created by zhuruhong on 15/6/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#ifndef RHToolkit_RHCommonDefines_h
#define RHToolkit_RHCommonDefines_h

// 屏幕尺寸
#define kScreenSize                 [UIScreen mainScreen].bounds.size
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kScreenScale                [UIScreen mainScreen].scale

#define kScreenRatio                (kScreenWidth/320)
#define kSizeFrom750(x)             (x*kScreenRatio*320/750)

#endif
