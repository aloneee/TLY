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
    
    [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:kUSERKEY];
    [kUserDefaults synchronize];
    
}

+(BOOL)existUser{
    
    return [kUserDefaults objectForKey:kUSERKEY] ? YES: NO;
}

+(NSString *)ticket{
    
    DDUser *user = [NSKeyedUnarchiver unarchiveObjectWithData: [kUserDefaults objectForKey:kUSERKEY]];
    
    return user.ticket;
}

@end
