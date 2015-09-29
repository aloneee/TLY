//
//  UIGestureRecognizer+Block.h
//  手势分类
//
//  Created by liurihua on 15/9/29.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureBlock)(UIGestureRecognizer *ges);

@interface UIGestureRecognizer (Block)

-(void)addActionHandler:(GestureBlock)actionHandler;

-(instancetype)initWithActionHandler:(GestureBlock)actionHandler;

- (void)removeActionHandler:(GestureBlock)actionHandler;

@end
