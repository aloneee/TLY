//
//  DDStoreScoreView.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDStoreScoreView.h"
#import "DDStoreScoreModel.h"

@interface DDStoreScoreView ()

@property(nonatomic, weak) UILabel *serviceScoreView;
@property(nonatomic, weak) UILabel *technologyScoreView;
@property(nonatomic, weak) UILabel *environmentScoreView;

@property(nonatomic, weak) UIView  *leftLine;
@property(nonatomic, weak) UIView  *rightLine;


@end

@implementation DDStoreScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

-(void)awakeFromNib{
    [self setupUI];
}


-(void)setupUI{
    
    UILabel *serviceScoreView = [[UILabel alloc] init];
    serviceScoreView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:serviceScoreView];
    self.serviceScoreView = serviceScoreView;
    
    UILabel *technologyScoreView = [[UILabel alloc] init];
    technologyScoreView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:technologyScoreView];
    self.technologyScoreView = technologyScoreView;
    
    UILabel *environmentScoreView = [[UILabel alloc] init];
    environmentScoreView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:environmentScoreView];
    self.environmentScoreView = environmentScoreView;
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor grayColor];
    [self addSubview:leftLine];
    self.leftLine = leftLine;
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor grayColor];
    [self addSubview:rightLine];
    self.rightLine = rightLine;
}


-(void)setScoreModel:(DDStoreScoreModel *)scoreModel{
    
    _scoreModel = scoreModel;
    self.serviceScoreView.text = scoreModel.serviceScore;
    self.technologyScoreView.text = scoreModel.technologyScore;
    self.environmentScoreView.text = scoreModel.environmentScore;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.serviceScoreView.x = 0;
    self.serviceScoreView.y = 0;
    self.serviceScoreView.width = (self.width - 2) / 3;
    self.serviceScoreView.height = self.height;
    
    self.leftLine.x = CGRectGetMaxX(self.serviceScoreView.frame);
    self.leftLine.y = self.height * 0.2;
    self.leftLine.width = 1;
    self.leftLine.height = self.height * 0.6;
    
    self.technologyScoreView.x = CGRectGetMaxX(self.leftLine.frame);
    self.technologyScoreView.y = 0;
    self.technologyScoreView.width = (self.width - 2) / 3;
    self.technologyScoreView.height = self.height;
    
    self.rightLine.x = CGRectGetMaxX(self.technologyScoreView.frame);
    self.rightLine.y = self.height * 0.2;
    self.rightLine.width = 1;
    self.rightLine.height = self.height * 0.6;
    
    self.environmentScoreView.x = CGRectGetMaxX(self.rightLine.frame);
    self.environmentScoreView.y = 0;
    self.environmentScoreView.width = (self.width - 2) / 3;
    self.environmentScoreView.height = self.height;
    
}







@end
