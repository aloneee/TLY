//
//  DDUserTool.m
//  特洛伊
//
//  Created by liurihua on 15/9/22.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDUserTool.h"

#define kUSERKEY  @"DDUSER"

@implementation DDUserTool

SingletonM(DDUserTool)


+(void)saveUser:(DDUser *)user{
    
    [kUser setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:kUSERKEY];
    [kUser synchronize];
    
}

+(BOOL)existUser{
    
    return [kUser objectForKey:kUSERKEY] ? YES: NO;
}

@end
