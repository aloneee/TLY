
//
//  DDHomeRecommendRewardViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/16.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeRecommendRewardViewController.h"

@interface DDHomeRecommendRewardViewController ()

@end

#define headImageHeight kScreenHeight * 0.4
#define kBottomBtnHeight 50

@implementation DDHomeRecommendRewardViewController

#pragma mark --- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐奖励";
    
    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    right.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    
    [right setTitleColor:[UIColor whiteColor]
                forState:UIControlStateNormal];
    [right setTitle:@"分享" forState:UIControlStateNormal];

    [right addTarget:self
              action:@selector(rightNavItemClick)
    forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
    
    self.tableView.contentInset  = UIEdgeInsetsMake(headImageHeight, 0, -kBottomBtnHeight, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -headImageHeight, kScreenWidth, headImageHeight)];
    headImageView.image = [UIImage imageNamed:@"img_03"];
    [self.view addSubview:headImageView];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, kScreen_Height - kBottomBtnHeight, kScreen_Width, kBottomBtnHeight);
    bottomBtn.backgroundColor = [UIColor orangeColor];
    
    [bottomBtn setTitle:@"立即分享给好友"
               forState:UIControlStateNormal];
    
    [bottomBtn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
    
    [bottomBtn addTarget:self
                  action:@selector(rightNavItemClick)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomBtn];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"测试小酱油呀～～～～";
    
    return cell;
}

#pragma mark --- helper
- (void)rightNavItemClick{
    NSLog(@"分享");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
