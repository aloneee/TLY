//
//  DDHttpTool.h
//  特洛伊
//
//  Created by liurihua on 15/9/23.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHttpTool : NSObject

SingletonH(Tool)


/**
 *  封装的post请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString  parameters:(NSDictionary *)parameters  success:(void (^)(id responseObject))success  failure:(void (^)( NSError *error))failure;
/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString    parameters:(NSDictionary *)parameters   success:(void (^)( id responseObject))success   failure:(void (^)( NSError *error))failure;
/**
 *  封装图片发送请求
 *
 *  @param URLString  请求链接
 *  @param parameters 请求参数
 *  @param picArray   存放图片模型的数组
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */


@end
