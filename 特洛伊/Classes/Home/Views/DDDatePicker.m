//
//  DDDatePicker.m
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDDatePicker.h"


@interface DDDatePicker ()

@property(nonatomic, weak) UIButton *cancleBtn;
@property(nonatomic, weak) UIButton *doneBtn;
@property(nonatomic, weak) UIDatePicker *datePicker;

@end

static const CGFloat kBtnW = 50.0f;


@implementation DDDatePicker

-(instancetype)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate{
    if (self = [super initWithFrame:frame]) {
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancleBtn setTitle:@"取消"
                   forState:UIControlStateNormal];
        
        //        [cancleBtn setTitleColor:[UIColor blueColor]
        //                        forState:UIControlStateNormal];
        
        cancleBtn.backgroundColor = [UIColor blueColor];
        cancleBtn.layer.cornerRadius = 5;
        [cancleBtn handleControlEvents:UIControlEventTouchUpInside
                             withBlock:^(id weakSender) {
            _cancleBlock(self);
        }];
        
        [self addSubview:cancleBtn];
        self.cancleBtn = cancleBtn;
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [doneBtn setTitle:@"确定"
                 forState:UIControlStateNormal];
        
        //        [doneBtn setTitleColor:[UIColor blueColor]
        //                        forState:UIControlStateNormal];
        doneBtn.backgroundColor = [UIColor blueColor];
        
        
        doneBtn.layer.cornerRadius = 5;
        [doneBtn handleControlEvents:UIControlEventTouchUpInside
                           withBlock:^(id weakSender) {
                               
            _doneBlock(self);
        }];
        
        [self addSubview:doneBtn];
        self.doneBtn = doneBtn;
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        
        datePicker.datePickerMode = datePickerMode;
        datePicker.minimumDate = minimumDate;
        datePicker.maximumDate = maximumDate;
        
        [self addSubview:datePicker];
        self.datePicker = datePicker;
    }
    
    
    return self;
}

-(NSDate *)date{
    
    return self.datePicker.date;
}


- (void)setDate:(NSDate *)date animated:(BOOL)animated{
    
    return [self.datePicker setDate:date animated:animated];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.cancleBtn.x = 0;
    self.cancleBtn.y = 0;
    self.cancleBtn.width = kBtnW;
    self.cancleBtn.height = self.height * 0.2;
    
    self.doneBtn.x = self.width - kBtnW;
    self.doneBtn.y = 0;
    self.doneBtn.width = kBtnW;
    self.doneBtn.height = self.height * 0.2;
    
    self.datePicker.x = 0;
    self.datePicker.y = self.height * 0.2;
    self.datePicker.width = self.width;
    self.datePicker.height = self.height * 0.8;
    
}

-(void)setCancleBlock:(DDDatePickerCancleBlock)cancleBlock{
    _cancleBlock = cancleBlock;
}

-(void)setDoneBlock:(DDDatePickerDoneBlock)doneBlock{
    _doneBlock = doneBlock;
}

@end
