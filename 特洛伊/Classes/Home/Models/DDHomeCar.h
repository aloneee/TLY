//
//  DDHomeCar.h
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHomeCar : NSObject <NSCoding>

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *mileAge;
@property(nonatomic, copy) NSString *numberOfYear;
@property(nonatomic, copy) NSString *carStartDate;
@property(nonatomic, copy) NSString *carProvinceName;
@property(nonatomic, copy) NSString *carCardNumber;
@property(nonatomic, copy) NSString *carId;
@property(nonatomic, copy) NSString *carTitle;
@property(nonatomic, copy) NSString *carSubTitle;
@property(nonatomic, copy) NSString *imageUrl;

@end
