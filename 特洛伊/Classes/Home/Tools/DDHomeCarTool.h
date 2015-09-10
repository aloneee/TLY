//
//  DDHomeCarTool.h
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDHomeCar;

@interface DDHomeCarTool : NSObject

SingletonH(DDHomeCarTool)

+ (void)saveCar:(DDHomeCar *)car;

+ (NSMutableArray *)getCars;

+ (void)removeCar:(DDHomeCar *)car;

@end
