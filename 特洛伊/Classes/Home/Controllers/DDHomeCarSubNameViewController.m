//
//  DDHomeCarSubNameViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/25.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeCarSubNameViewController.h"
#import "DDParentCar.h"

@interface DDHomeCarSubNameViewController ()
@property (nonatomic, strong) NSMutableArray *cars;

@end

@implementation DDHomeCarSubNameViewController

#pragma mark --- lazy load
-(NSMutableArray *)cars{
    if (!_cars) {
        _cars = [NSMutableArray array];
    }
    return _cars;
}


#pragma mark ---- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择车型";
    
    [[DDHttpTool sharedTool] POST:DDGetCarBrandsUrl
                       parameters:@{@"parentId":self.carId}
                          success:^(id responseObject){
        NSLog(@"%@",responseObject);
        
        self.cars = [DDParentCar objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    DDParentCar *car = self.cars[indexPath.row];
    cell.textLabel.text = car.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DDParentCar *car = self.cars[indexPath.row];
    
    [kNote postNotificationName:@"DidSelectCarName"
                         object:nil
                       userInfo:@{@"carName":car.name}];
    
    
    [self.navigationController popToViewController:self.navigationController.childViewControllers[1]
                                          animated:YES];
}


@end
