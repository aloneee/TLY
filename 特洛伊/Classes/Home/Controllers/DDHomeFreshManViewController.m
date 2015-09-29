

//
//  DDHomeFreshManViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/16.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeFreshManViewController.h"

@interface DDHomeFreshManViewController ()

@end

#define headImageHeight kScreenHeight * 0.25

@implementation DDHomeFreshManViewController

#pragma mark --- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新人注册大礼包";
    
    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    right.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
    
    [right setTitleColor:[UIColor whiteColor]
                forState:UIControlStateNormal];
    
    [right setTitle:@"分享"
           forState:UIControlStateNormal];
    
    [right handleControlEvents:UIControlEventTouchUpInside
                     withBlock:^(id weakSender) {
                         
        NSLog(@"分享");
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.tableView.contentInset  = UIEdgeInsetsMake(headImageHeight, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -headImageHeight, kScreenWidth, headImageHeight)];
    headImageView.image = [UIImage imageNamed:@"img_03"];
    [self.view addSubview:headImageView];
}


#pragma mark - Table view dataSource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
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
