//
//  DDUser.h
//  特洛伊
//
//  Created by liurihua on 15/9/22.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUser : NSObject <NSCoding>

/**
 *  头像url
 */
@property(nonatomic, copy) NSString *iconImg;
/**
 *  用户名
 */
@property(nonatomic, copy) NSString *userName;

/**
 *  用户手机号
 */
@property(nonatomic, copy) NSString *phoneNum;


@end
