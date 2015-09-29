//
//  DDCommentFrameModle.m
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#define DDPadding 10

#import "DDCommentFrameModle.h"
#import "DDCommenModel.h"

@implementation DDCommentFrameModle

-(void)setCommentModel:(DDCommenModel *)commentModel{
    _commentModel = commentModel;
    
    /**
     *  评论头像Frame;
     */
    CGFloat headImageX = DDPadding;
    CGFloat headImageY = DDPadding;
    CGFloat headImageW = 40;
    CGFloat headImageH = 40;
    _headImageFrame = (CGRect){{headImageX,headImageY},{headImageW,headImageH}};
    
    /**
     * 发布时间Frame
     */
     
    CGFloat timeX = CGRectGetMaxX(_headImageFrame) + DDPadding;
    CGFloat timeY = DDPadding;
    CGSize timeSize = [commentModel.postTime boundingRectWithSize:CGSizeMake(kScreen_Width - 3 * DDPadding - headImageW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : DDCommentTimeFont} context:nil].size;
    _postTimeFrame = (CGRect){{timeX,timeY},timeSize};
    
    /**
     *  评论Frame
     */
    CGFloat commentX = DDPadding;
    CGFloat commentY = MAX(CGRectGetMaxY(_headImageFrame), CGRectGetMaxY(_postTimeFrame)) + DDPadding;
    CGSize commentSize = [commentModel.comment boundingRectWithSize:CGSizeMake(kScreen_Width - 2 * DDPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : DDCommentFont} context:nil].size;
    _commentFrame = (CGRect){{commentX,commentY},commentSize};
    
    _cellHeight = CGRectGetMaxY(_commentFrame) + DDPadding;
    
}

@end
