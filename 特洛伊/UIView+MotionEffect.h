//
//  UIView+MotionEffect.h
//  testView
//
//  Created by xiaoxiaobing on 15/2/27.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MotionEffect)

@property (nonatomic, strong) UIMotionEffectGroup  *effectGroup;
- (void)addXAxisWithValue:(CGFloat)xValue YAxisWithValue:(CGFloat)yValue;
- (void)removeSelfMotionEffect;
@end
