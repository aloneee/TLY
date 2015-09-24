//
//  DDHomeChoseCarViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeChoseCarViewController.h"
#import "DDParentCar.h"



//#import "SkyAssociationMenuView.h"
@interface DDHomeChoseCarViewController ()<UITableViewDataSource,UITableViewDelegate>//<SkyAssociationMenuViewDelegate>

@property(nonatomic, strong)  UITableView           *leftTable;
@property(nonatomic, strong)  UITableView           *rightTable;

//@property (nonatomic, strong) NSMutableArray        *s;
@property (nonatomic, strong) NSMutableDictionary   *brandDict;
@property (nonatomic, strong) NSMutableArray        *brandArray;

@end

@implementation DDHomeChoseCarViewController


#pragma marhk ---- lazy load

-(NSMutableDictionary *)brandDict{
    
    if (!_brandDict) {
        _brandDict = [NSMutableDictionary dictionary];
    }
    return _brandDict;
}

-(NSMutableArray *)brandArray{
    if (!_brandArray) {
        _brandArray = [NSMutableArray array];
    }
    return _brandArray;
}

-(UITableView *)leftTable{
    if (_leftTable == nil) {
        self.leftTable = ({
            UITableView *leftTable = [[UITableView alloc] initWithFrame:({
                CGRect frame = CGRectMake(0, kNavgationBarHeight, kScreen_Width, kScreen_Height - kNavgationBarHeight - kTabBarHeight);
                frame;
            }) style:UITableViewStylePlain];
            leftTable.delegate = self;
            leftTable.dataSource = self;
            [self.view addSubview:leftTable];
            leftTable;
        });
    }
    
    return _leftTable;
}

-(UITableView *)rightTable{
    if (_rightTable == nil) {
        self.rightTable = ({
            UITableView *rightTable= [[UITableView alloc] initWithFrame:({
                CGRect frame = CGRectMake(kScreen_Width +  5, kNavgationBarHeight, kScreen_Width, kScreen_Height - kNavgationBarHeight - kTabBarHeight);
                frame;
            }) style:UITableViewStylePlain];
            rightTable.delegate = self;
            rightTable.dataSource = self;
            [self.view addSubview:rightTable];
            rightTable;
        });
    }
    
    return _leftTable;
}


#pragma mark ---- life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择品牌";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.leftTable];
    [self.view addSubview:self.rightTable];
    
    [[DDHttpTool sharedTool] POST:DDGetCarBrandsUrl parameters:@{@"parentId":@0} success:^(id responseObject) {
        
        NSLog(@"%@",responseObject[@"result"]);
        
        for (NSString *key in responseObject[@"result"]) {
            
            NSArray *newCars = [DDParentCar objectArrayWithKeyValuesArray:[responseObject[@"result"] objectForKey:key]];
            [self.brandDict setObject:newCars forKey:key];
        }
//        NSLog(@"%@",self.brandDict);
        
        NSMutableArray *a = [NSMutableArray array];
        for (int i = 'A'; i <= 'Z'; i++) {
            for (NSString *k in self.brandDict) {

                NSMutableDictionary *d = [NSMutableDictionary dictionary];
                
                if ([k isEqualToString:[NSString stringWithFormat:@"%c",i]]) {
                    [d setObject:self.brandDict[k] forKey:k];
                    [a addObject:d];
                }
            }
        }
        [self.brandArray addObjectsFromArray:a];
        
        NSLog(@"%@",self.brandArray);
        
//        self.leftTable headerViewForSection:<#(NSInteger)#>
        
        [self.leftTable reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}



#pragma mark ----tableVie delegate & dataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTable) {
        return  self.brandArray.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTable) {
        NSDictionary *d = self.brandArray[section];
        NSString *key = [d allKeys][0];
        return [[d objectForKey:key] count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSLog(@"%@",self.brandArray);
    
    
    NSDictionary *d = self.brandArray[indexPath.section];
    NSString *key = [d allKeys][0];
    DDParentCar *car = [d objectForKey:key][indexPath.row];
    cell.textLabel.text = car.name;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (tableView == self.leftTable) {
        if (self.brandArray.count) {
            return [self.brandArray[section] allKeys][0];
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
