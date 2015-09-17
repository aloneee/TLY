//
//  DDHomeTableHeadView.m
//  特洛伊
//
//  Created by liurihua on 15/9/16.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeTableHeadView.h"

@interface DDHomeTableHeadView ()

@property (nonatomic, weak) UILabel       *leftLabel;
@property (nonatomic, weak) UILabel       *rightLabel;

@end

@implementation DDHomeTableHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.textColor = [UIColor whiteColor];
        [self addSubview:leftLabel];
        self.leftLabel = leftLabel;
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.textColor = [UIColor whiteColor];
        [self addSubview:rightLabel];
        self.rightLabel = rightLabel;
        
        self.backgroundColor = ColorWithHexAlpha(0x000000, 0.7);
    }
    return self;
}

-(void)setLeftText:(NSString *)leftText{
    _leftText = leftText;
    self.leftLabel.text = leftText;
}

-(void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    self.rightLabel.text = rightText;
}

+(DDHomeTableHeadView *)headView{
    
    return [[[self class] alloc] init];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(0, 0, kScreenWidth * 0.5, self.height);
    self.rightLabel.frame = CGRectMake(kScreenWidth * 0.5, 0, kScreenWidth * 0.5, self.height);
    
}

- (void)setFrame:(CGRect)frame{
    
    if (self.adjustFrame) {
        CGRect sectionRect = [self.tableView rectForSection:self.section];
        frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    }
    
    [super setFrame:frame];
}



@end
