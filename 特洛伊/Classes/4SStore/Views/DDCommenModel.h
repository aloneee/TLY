//
//  DDCommenModel.h
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCommenModel : NSObject


/**
 *  头像
 */
@property(nonatomic, copy) NSString *headImageUrl;
/**
 *  评论发布时间
 */
@property(nonatomic, copy) NSString *postTime;

/**
 *  评论
 */
@property(nonatomic, copy) NSString *comment;

@end
