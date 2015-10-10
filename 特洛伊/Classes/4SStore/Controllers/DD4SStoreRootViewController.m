

//
//  DD4SStoreRootViewController.m
//  特洛伊
//
//  Created by liurihua on 15/10/10.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DD4SStoreRootViewController.h"
#import "DOPDropDownMenu.h"
#import "DD4SStoreDetailViewController.h"

@interface DD4SStoreRootViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSArray         *areas;
@property (nonatomic, strong) NSArray         *beijingRegions;
@property (nonatomic, strong) NSArray         *serviceTypes;
@property (nonatomic, strong) NSArray         *carTypes;
@property (nonatomic, strong) NSArray         *sorts;
@property(nonatomic, weak)    UITableView     *tableView;

@property (nonatomic, weak)   DOPDropDownMenu *menu;

@end

static const CGFloat kTopBtnHeight = 44;

@implementation DD4SStoreRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 数据
    self.serviceTypes = @[@"服务保养",
                          @"汽车美容",
                          @"汽车维修"];
    
    self.areas = @[@"北京",
                   @"上海",
                   @"天津",
                   @"河北",
                   @"广州"];
    
    self.beijingRegions = @[@"东城区",
                            @"西城区",
                            @"海淀区",
                            @"朝阳区",
                            @"丰台区",
                            @"石景山区",
                            @"顺义区"];
    
    self.sorts = @[@"默认排序",
                   @"离我最近",
                   @"好评优先",
                   @"人气优先",
                   @"最新发布"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, kNavgationBarHeight) andHeight:kTopBtnHeight];
    menu.initialTitles = @[@"服务类型",@"区域",@"车辆类型",@"智能排序"];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    self.menu = menu;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menu.frame), kScreen_Width, kScreen_Height - kTopBtnHeight - kNavgationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

}


#pragma mark ---- DOPDropMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.serviceTypes.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.serviceTypes[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 1) {
        if (row == 0) {
            return self.beijingRegions.count;
        } else if (row == 2){
            return self.beijingRegions.count;
        } else if (row == 3){
            return self.beijingRegions.count;
        }else{
            return self.beijingRegions.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 1) {
        if (indexPath.row == 0) {
            return self.beijingRegions[indexPath.item];
        } else if (indexPath.row == 2){
            return self.beijingRegions[indexPath.item];
        } else if (indexPath.row == 3){
            return self.beijingRegions[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"测试小酱油呀...00000";
    }else{
        cell.textLabel.text = @"测试小酱油呀...11111";
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DD4SStoreDetailViewController *storeDetail = [[DD4SStoreDetailViewController alloc] init];
    [self.navigationController pushViewController:storeDetail animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSArray*)tableView:(UITableView *)tableView
editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *actions = [NSMutableArray array];
    
    NSArray *titles = @[@"置顶",
                        @"标为未读",
                        @"删除"];
    
    NSArray *colors = @[[UIColor grayColor],
                        [UIColor yellowColor],
                        [UIColor redColor]];
    
    for (NSInteger i = titles.count - 1; i >= 0; i--) {
        
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:titles[i]
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                            NSLog(@"%@,%@",indexPath,action.title);
                                                                        }];
        action.backgroundColor = colors[i];
        
        [actions addObject:action];
    }
    
    return actions;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@lllllllll",indexPath);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
