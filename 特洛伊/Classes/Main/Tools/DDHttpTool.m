//
//  DDHttpTool.m
//  特洛伊
//
//  Created by liurihua on 15/9/23.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHttpTool.h"
#import <AFNetworking.h>

@implementation DDHttpTool

SingletonM(Tool)
/**
 *  封装的post请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */

- (void)POST:(NSString *)URLString  parameters:(NSDictionary *)parameters  success:(void (^)(id responseObject))success  failure:(void (^)( NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 10;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
//        NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess
//                                                          title:@"信息"
//                                                        message:@"网络给力"
//                                                       delegate:nil];
//        [alert show];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"%@",[error localizedDescription]);
        
//        NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
//                                                          title:@"信息"
//                                                        message:@"网络不给力"
//                                                       delegate:nil];
//        [alert show];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }]; 
    
}
/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString    parameters:(NSDictionary *)parameters   success:(void (^)( id responseObject))success   failure:(void (^)( NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 10;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
//        NSLog(@"%@ %@ %@",URLString, parameters, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"%@",[error localizedDescription]);
        NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                          title:@"信息"
                                                        message:@"网络不给力"
                                                       delegate:nil];
        [alert show];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


@end
