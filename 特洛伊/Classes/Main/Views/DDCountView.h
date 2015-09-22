//
//  DDCountView.h
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDCountView;

typedef void (^DDCountViewValueChangeBlock) (DDCountView *);

@interface DDCountView : UIView

@property(nonatomic, assign) NSInteger                    minCount;
@property(nonatomic, assign) NSInteger                    maxCount;
@property(nonatomic, assign) NSInteger                    count;

@property(nonatomic, copy)   DDCountViewValueChangeBlock  block;


@end
