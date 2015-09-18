//
//  DDBackView.h
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDBackView;

typedef void (^DDBackViewTouchBeginBlock) (DDBackView *);

@interface DDBackView : UIView

@property(nonatomic, copy) DDBackViewTouchBeginBlock block;

@end
