//
//  DDHomeSpecificPreferentialViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/16.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeSpecificPreferentialViewController.h"
#import "DDHomeTableHeadView.h"

@interface DDHomeSpecificPreferentialViewController ()

@end

#define headImageHeight kScreen_Height * 0.25
#define topHintViewHeight 30

@implementation DDHomeSpecificPreferentialViewController

#pragma mark --- life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"每日整点";
    
    self.tableView.contentInset  = UIEdgeInsetsMake(headImageHeight + topHintViewHeight, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -headImageHeight, kScreen_Width, headImageHeight)];
    headImageView.image = [UIImage imageNamed:@"img_03"];
    [self.view addSubview:headImageView];
    
    DDHomeTableHeadView *headView = [DDHomeTableHeadView headView];
    headView.frame = CGRectMake(0, -headImageHeight - topHintViewHeight, kScreen_Width, topHintViewHeight);
    headView.leftText = @"今晚8点整点大优惠";
    headView.rightText = @"剩余时间: 00:00";
    
    [self.view addSubview:headView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDHomeTableHeadView *headView = [DDHomeTableHeadView headView];
    headView.leftText = @"啦啦啦";
    headView.rightText = @"剩余时间: 00:00";
    headView.section = section;
    headView.tableView = tableView;
    headView.adjustFrame = YES;
    return headView;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    YGSectionHeaderView *sectionHead = [[YGSectionHeaderView alloc] init];
//    
//    sectionHead.section = section;
//    
//    sectionHead.tableView = tableView;
//    
//    return sectionHead;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
