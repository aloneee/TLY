//
//  DDMaintanceDetailModel.h
//  特洛伊
//
//  Created by liurihua on 15/10/12.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDMaintanceDetailModel : NSObject

@property(nonatomic, copy)   NSString   *titleStr;
@property(nonatomic, copy)   NSString   *price;
@property(nonatomic, copy)   NSString   *originalPrice;
@property(nonatomic, copy)   NSString   *distance;
@property(nonatomic, copy)   NSString   *storeName;
@property(nonatomic, assign) BOOL       extend;

@end
