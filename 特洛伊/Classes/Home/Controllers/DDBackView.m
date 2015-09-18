//
//  DDBackView.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDBackView.h"

@implementation DDBackView

-(void)setBlock:(DDBackViewTouchBeginBlock)block{
    _block = block;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    _block(self);
}

@end
