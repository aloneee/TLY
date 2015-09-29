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

#pragma mark ---- lazy load
-(NSMutableArray *)citys{
    if (!_citys) {
        _citys = [NSMutableArray arrayWithObjects:
                  @"北京市",
                  @"长春市",
                  @"上海市",
                  @"天津市",
                  @"重庆市",
                  @"石家庄市",
                  nil];
    }
    return _citys;
}

#pragma mark --- life cycle
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
    
    [left handleControlEvents:UIControlEventTouchUpInside
                    withBlock:^(id weakSender) {
        
        [self.navigationController popViewControllerAnimated:YES];

    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
}


#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
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


#pragma mark --- helper

@end
