//
//  DDHomePersonalMaintenanceViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/18.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomePersonalMaintenanceViewController.h"
#import "DDHomeIndividualMaintenanceViewCell.h"

@interface DDHomePersonalMaintenanceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *hintView;

@property (weak, nonatomic) IBOutlet UIButton *goToMaintenanceBtn;

@end

@implementation DDHomePersonalMaintenanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性保养方案";
    
    self.goToMaintenanceBtn.layer.cornerRadius = 5;
    self.table.allowsMultipleSelection = YES;
    self.table.delegate = self;
    self.table.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDHomeIndividualMaintenanceViewCell *cell = [DDHomeIndividualMaintenanceViewCell cellForTabelView:tableView];
    
    cell.textLabel.text = @"测试酱油～～～";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hintView.text = [NSString stringWithFormat:@"共%ld项",[[self.table indexPathsForSelectedRows] count]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hintView.text = [NSString stringWithFormat:@"共%ld项",[[self.table indexPathsForSelectedRows] count]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)gotoMaintenanceBtnClick:(id)sender {
    NSLog(@"%@",[self.table indexPathsForSelectedRows]);
}

@end
