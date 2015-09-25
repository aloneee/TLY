//
//  DDTouchBeginView.h
//  特洛伊
//
//  Created by liurihua on 15/9/25.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DDTouchBeginBlock)(void);

@interface DDTouchBeginView : UIView

@property(nonatomic, copy) DDTouchBeginBlock block;

@end
