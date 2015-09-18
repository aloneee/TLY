//
//  DDDatePicker.h
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDDatePicker;

typedef  void(^DDDatePickerCancleBlock) (DDDatePicker *);
typedef  void(^DDDatePickerDoneBlock) (DDDatePicker *);

@interface DDDatePicker : UIView

@property(nonatomic, copy) DDDatePickerCancleBlock cancleBlock;
@property(nonatomic, copy) DDDatePickerDoneBlock doneBlock;

@property (nonatomic, retain) NSDate *date;

- (instancetype)initWithFrame:(CGRect)frame datePickerMode:(UIDatePickerMode)datePickerMode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate;

@property(nonatomic, assign) BOOL isShow;

@end
