//
//  DDHomeTableHeadView.h
//  特洛伊
//
//  Created by liurihua on 15/9/16.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDHomeTableHeadView : UIView

@property(nonatomic, copy) NSString *leftText;

@property(nonatomic, copy) NSString *rightText;


@property NSUInteger section;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) BOOL adjustFrame;

+(DDHomeTableHeadView *)headView;

@end
