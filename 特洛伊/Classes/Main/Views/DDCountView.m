//
//  DDCountView.m
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDCountView.h"

@interface DDCountView ()

@property(nonatomic, weak) UIButton    *minusBtn;
@property(nonatomic, weak) UIButton    *addBtn;
@property(nonatomic, weak) UILabel     *countLabel;

@end

@implementation DDCountView

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

//-(void)setMinCount:(NSInteger)minCount{
//    _minCount = minCount;
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",minCount];
//}

-(void)setCount:(NSInteger)count{
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count];
}

-(void)setupUI{
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textAlignment = NSTextAlignmentCenter;
//    countLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:countLabel];
    self.countLabel = countLabel;
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    minusBtn.layer.cornerRadius = 5;
    minusBtn.backgroundColor = [UIColor redColor];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusBtn];
    self.minusBtn = minusBtn;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.layer.cornerRadius = 5;
    addBtn.backgroundColor = [UIColor greenColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    self.addBtn = addBtn;
    
    self.count = 1;
    self.minCount = NSIntegerMin;
    self.maxCount = NSIntegerMax;
}

-(void)setBlock:(DDCountViewValueChangeBlock)block{
    _block = block;
}

- (void)minusBtnClick:(UIButton *)sender{
    
    if (self.count > self.minCount) {
        self.count--;
    }
    
    _block(self);
}

- (void)addBtnClick:(UIButton *)sender{
    
    if (self.count < self.maxCount) {
        self.count++;
    }
    
    _block(self);
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.minusBtn.x = 0;
    self.minusBtn.y = 0;
    self.minusBtn.width = self.width * 0.25;
    self.minusBtn.height = self.height;
    
    self.countLabel.x = CGRectGetMaxX(self.minusBtn.frame);
    self.countLabel.y = 0;
    self.countLabel.width = self.width * 0.5;
    self.countLabel.height = self.height;
    
    self.addBtn.x = CGRectGetMaxX(self.countLabel.frame);
    self.addBtn.y = 0;
    self.addBtn.width = self.width * 0.25;
    self.addBtn.height = self.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
