//
//  DDHomeTestReportViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/17.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeTestReportViewController.h"
#import "DDHomeMaintenanceDetailViewController.h"

@interface DDHomeTestReportViewController ()

@property (weak, nonatomic) IBOutlet UITableView     *table;
@property (weak, nonatomic) IBOutlet UILabel         *carHealthHintView;
@property (weak, nonatomic) IBOutlet UIImageView     *headImageView;

@end

@implementation DDHomeTestReportViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"检测报告";
    self.headImageView.image = [UIImage captureCircleImageWithImage:[UIImage imageNamed:@"img_03"]
                                                      andBorderWith:2.0f
                                                     andBorderColor:[UIColor blackColor]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --- helper

- (IBAction)goToMaintenance:(id)sender {
    
    DDHomeMaintenanceDetailViewController *md = [[DDHomeMaintenanceDetailViewController alloc] init];
    
    [self.navigationController pushViewController:md
                                         animated:YES];
}


 

 


@end
