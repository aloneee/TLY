//
//  DDCommentFrameModle.h
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//



#define DDCommentTimeFont [UIFont systemFontOfSize:12]
#define DDCommentFont [UIFont systemFontOfSize:15]
//#define RHartistsNameFont [UIFont systemFontOfSize:12]
//#define RHTotalViewsFont [UIFont systemFontOfSize:12]
//#define RHDurationFont [UIFont systemFontOfSize:12]
//#define RHDescriptionFont [UIFont systemFontOfSize:12]

#import <Foundation/Foundation.h>

@class DDCommenModel;

@interface DDCommentFrameModle : NSObject

/**
 *  头像
 */
@property(nonatomic, assign, readonly) CGRect headImageFrame;
/**
 *  评论发布时间
 */
@property(nonatomic, assign, readonly) CGRect postTimeFrame;

/**
 *  评论
 */
@property(nonatomic, assign, readonly) CGRect commentFrame;

/**
 *  cell高度
 */
@property(nonatomic, assign, readonly) CGFloat cellHeight;


@property (nonatomic, strong) DDCommenModel *commentModel;

@end
