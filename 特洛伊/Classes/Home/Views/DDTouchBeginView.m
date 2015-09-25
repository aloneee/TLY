
//
//  DDTouchBeginView.m
//  特洛伊
//
//  Created by liurihua on 15/9/25.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDTouchBeginView.h"

@implementation DDTouchBeginView


-(void)setBlock:(DDTouchBeginBlock)block{
    _block = block;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _block();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
