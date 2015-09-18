//
//  DDHomeMyCarsViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeMyCarsViewController.h"
#import "DDHomeAddCarInfoViewController.h"
#import "DDHomeMyCarCell.h"
#import "DDHomeMyCar.h"

@interface DDHomeMyCarsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak)    UITableView      *table;
@property (nonatomic, strong)  NSMutableArray    *cars;

@end

@implementation DDHomeMyCarsViewController


-(NSMutableArray *)cars{
    if (!_cars) {
        _cars = [NSMutableArray array];
        //get cars
        DDHomeMyCar *myCar = [[DDHomeMyCar alloc] init];
        myCar.carTitle = @"奥迪";
        myCar.carSubTitle = @"酱油A1";
        [_cars addObject:myCar];
        [_cars addObject:myCar];
        [_cars addObject:myCar];
        [_cars addObject:myCar];
        
        NSLog(@"%@",_cars);
//        [self.table reloadData];
    }
    
    return _cars;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeight - 50) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 70;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    self.table = table;
    
    
    UIButton *addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCarBtn.frame = CGRectMake(20, kScreenHeight - 50, kScreenWidth - 40, 30);
    addCarBtn.layer.cornerRadius = 5;
    addCarBtn.backgroundColor = [UIColor orangeColor];
    
    [addCarBtn setTitle:@"添加爱车"
               forState:UIControlStateNormal];
    
    [addCarBtn addTarget:self
                  action:@selector(addCar:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addCarBtn];
}

-(void)addCar:(UIButton *)sender{
    
    DDHomeAddCarInfoViewController *addCarInfo = [[UIStoryboard storyboardWithName:@"Main"
                                                                            bundle:nil]
                                                  instantiateViewControllerWithIdentifier:@"addCarInfo"];
    NSLog(@"%@",addCarInfo);
    
    [self.navigationController pushViewController:addCarInfo animated:YES];
}

#pragma mark ---- tableView Delegate  and  dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%ld",self.cars.count);
    
    return self.cars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDHomeMyCarCell *cell = [DDHomeMyCarCell cellForTabelView:tableView];
    
    cell.myCar = self.cars[indexPath.row];
    
    return cell;

}

@end
