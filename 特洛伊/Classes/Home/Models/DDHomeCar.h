//
//  DDHomeCar.h
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHomeCar : NSObject <NSCoding>

@property(nonatomic, copy) NSString *carBrand;
@property(nonatomic, copy) NSString *currentKM;
@property(nonatomic, copy) NSString *numberOfYear;
@property(nonatomic, copy) NSString *buyDate;
@property(nonatomic, copy) NSString *licensePlateNumber;

@end
