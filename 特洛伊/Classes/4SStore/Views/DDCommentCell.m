//
//  DDCommentCell.m
//  特洛伊
//
//  Created by liurihua on 15/9/21.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDCommentCell.h"
#import "DDCommentFrameModle.h"
#import "DDCommenModel.h"

@interface DDCommentCell ()

@property(nonatomic, weak) UIImageView    *headImageView;

@property(nonatomic, weak) UILabel        *timeView;

@property(nonatomic, weak) UILabel       *commentView;


@end

@implementation DDCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:headImageView];
        self.headImageView = headImageView;
        
        UILabel *timeView = [[UILabel alloc] init];
        timeView.numberOfLines = 0;
        timeView.font = DDCommentTimeFont;
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        UILabel *commentView = [[UILabel alloc] init];
        commentView.numberOfLines = 0;
        commentView.font = DDCommentFont;
        [self.contentView addSubview:commentView];
        self.commentView = commentView;
        
    }
    
    return self;
}


-(void)setCommentFrameModel:(DDCommentFrameModle *)commentFrameModel{
    _commentFrameModel = commentFrameModel;
    
//    self.headImageView   geti image frome url  via SDWebImage
    self.headImageView.frame = commentFrameModel.headImageFrame;
    self.headImageView.image = [UIImage captureCircleImageWithImage:[UIImage imageNamed:@"img_03"]
                                                      andBorderWith:2.0
                                                     andBorderColor:[UIColor orangeColor]];
    
    self.timeView.frame = commentFrameModel.postTimeFrame;
    self.timeView.text = commentFrameModel.commentModel.postTime;
    
    self.commentView.frame = commentFrameModel.commentFrame;
    self.commentView.text = commentFrameModel.commentModel.comment;
    
    
}


+(DDCommentCell *)cellWithTableView:(UITableView *)tableView{
    
    static NSString *identifier = @"commentCell";
    DDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DDCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
