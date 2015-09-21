
//
//  DD4SStoreCommentViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DD4SStoreCommentViewController.h"
#import "DDStoreScoreModel.h"
#import "DDStoreScoreView.h"
#import "DDCommentCell.h"
#import "DDCommentFrameModle.h"
#import "DDCommenModel.h"

@interface DD4SStoreCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet DDStoreScoreView *topView;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic, strong) NSMutableArray *comments;


@end

@implementation DD4SStoreCommentViewController


-(NSArray *)comments{
    if (!_comments) {
        _comments = [NSMutableArray array];
        
        for (int i = 0; i < 5; i++) {
            DDCommentFrameModle *frameModel = [[DDCommentFrameModle alloc] init];
            DDCommenModel *commentModle = [[DDCommenModel alloc] init];
            commentModle.postTime = @"jdkjfdsjkfsdajf";
            commentModle.comment = @"dkhfuaehfiuhdioufgheiowfuheiuhfiueldhsfnoudshfoudhgsksdjdiouehrfwiukdhadauhafiuhewqiohiouh";
            frameModel.commentModel = commentModle;
            
            [_comments addObject:frameModel];
        }
        
        
        for (int i = 0; i < 5; i++) {
            DDCommentFrameModle *frameModel = [[DDCommentFrameModle alloc] init];
            DDCommenModel *commentModle = [[DDCommenModel alloc] init];
            commentModle.postTime = @"jdkjfdsjkfsdajfdilfjgdoifgjldsijfldsjfljsflkjdsklfjdslafjdsakjfhakjds";
            commentModle.comment = @"dkhfuaehfiuhdioufgheiowfuheiuhfiueldhsfnoudshfoudhgsksdjdiouehrfwiukdhadauhafiuhewqiohiouhdlskjflsdkjfsdlkjfkdshfjioerhreowiljfkhdfjsl;kdsjfkjpewooiheokoihjdsoijfsj";
            frameModel.commentModel = commentModle;
            
            [_comments addObject:frameModel];
        }
    }
    
    NSLog(@"%@",_comments);
    
    return _comments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    DDStoreScoreModel *scoreModel = [[DDStoreScoreModel alloc] init];
    scoreModel.serviceScore = @"服务5.0";
    scoreModel.technologyScore = @"技术5.0";
    scoreModel.environmentScore = @"环境5.0";
    
    self.topView.scoreModel = scoreModel;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.comments.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDCommentCell *cell = [DDCommentCell cellWithTableView:tableView];
    
    cell.commentFrameModel = self.comments[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDCommentFrameModle *frameModel = (DDCommentFrameModle *)self.comments[indexPath.row];
    
    return frameModel.cellHeight;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
