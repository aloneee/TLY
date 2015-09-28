//
//  DDUserTool.h
//  特洛伊
//
//  Created by liurihua on 15/9/22.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDUser;

@interface DDUserTool : NSObject

SingletonH(DDUserTool)

+(void)saveUser:(DDUser *)user;

+(BOOL)existUser;

+(NSString *)ticket;

@end
