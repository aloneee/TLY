
//
//  UIGestureRecognizer+Block.m
//  手势分类
//
//  Created by liurihua on 15/9/29.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/runtime.h>

static const void *GestureBlockKey = &GestureBlockKey;

@implementation UIGestureRecognizer (Block)

-(instancetype)initWithActionHandler:(GestureBlock)actionHandler{
    
    if (self = [self init]) {
        
        objc_setAssociatedObject(self, GestureBlockKey, actionHandler, OBJC_ASSOCIATION_COPY);
        [self addTarget:self
                 action:@selector(action:)];
    }
    return self;
}


-(void)addActionHandler:(GestureBlock)actionHandler{
    objc_setAssociatedObject(self, GestureBlockKey, actionHandler, OBJC_ASSOCIATION_COPY);
    [self addTarget:self
             action:@selector(action:)];
}

-(void)removeActionHandler:(GestureBlock)actionHandler{
    objc_setAssociatedObject(self, GestureBlockKey, actionHandler, OBJC_ASSOCIATION_COPY);
    [self removeTarget:self
                action:@selector(action:)];
}

-(void)action:(UIGestureRecognizer *)ges{
    GestureBlock block = objc_getAssociatedObject(self, GestureBlockKey);
    if (block) {
        block(self);
    }
}


@end
