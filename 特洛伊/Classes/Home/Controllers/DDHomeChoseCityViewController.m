//
//  DDHomeChoseCityViewController.m
//  特洛伊
//
//  Created by liurihua on 15/8/24.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeChoseCityViewController.h"
#import "DDHomeCityCell.h"

@interface DDHomeChoseCityViewController ()

@property (nonatomic, strong) NSMutableArray        *citys;

@end

@implementation DDHomeChoseCityViewController


-(NSMutableArray *)citys{
    if (!_citys) {
        _citys = [NSMutableArray arrayWithObjects:@"北京市",@"长春市",@"上海市",@"天津市",@"重庆市",@"石家庄市", nil];
    }
    return _citys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    left.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [left setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    
    left.frame = CGRectMake(0, 0, 80, 30);
    
    [left setTitle:@"返回"
          forState:UIControlStateNormal];
    
    [left addTarget:self
             action:@selector(popBack)
   forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
}

- (void) popBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (0 == section) {
        return 1;
    }
    return self.citys.count;
}


- (DDHomeCityCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDHomeCityCell *cell = [DDHomeCityCell cellForTabelView:tableView];
    
    if (0 == indexPath.section) {
        cell.city = @"北京市";
    }
    else{
        cell.city = self.citys[indexPath.row];
    }
    
    cell.returnCityBlock = ^(DDHomeCityCell *homeCityCell){
        [self.userLocationBtn setTitle:homeCityCell.city
                              forState:UIControlStateNormal];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    
    if (0 == section) {
        return @"当前位置";
    }else{
        return @"已开通城市";
    }
}

@end
