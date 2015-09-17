//
//  DD4SDropMenusView.m
//  特洛伊
//
//  Created by liurihua on 15/9/10.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DD4SDropMenusView.h"


@interface DD4SDropMenusView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray      *serviceTypes;
@property (nonatomic, strong) NSMutableArray      *carTypes;
@property (nonatomic, strong) NSMutableArray      *sortTypes;

@property (nonatomic, strong) UIView              *showDropMenu;

@end


@implementation DD4SDropMenusView

#pragma mark --- lazyLoad

-(NSMutableArray *)serviceTypes{
    if (!_serviceTypes) {
        _serviceTypes = [NSMutableArray arrayWithArray:@[@"mutherfucker",@"汽车美容",@"汽车维修"]];
    }
    return _serviceTypes;
}

-(NSMutableArray *)carTypes{
    if (!_carTypes) {
        _carTypes = [NSMutableArray arrayWithArray:@[@"汽车保养",@"汽车美容",@"汽车维修"]];
    }
    return _carTypes;
}

-(NSMutableArray *)sortTypes{
    if (!_sortTypes) {
        _sortTypes = [NSMutableArray arrayWithArray:@[@"not so fast ",@"附近有限",@"评分最高",@"价格最高",@"价格最低"]];
    }
    return _sortTypes;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        NSArray *btnTitles = @[@"服务品类",@"区域",@"车辆品牌",@"智能排序"];
        
        
        
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(btnW * i, 0, btnW, kTopBtnHeight);
            btn.backgroundColor = [UIColor greenColor];
            btn.tag = i;
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            if (i == 1) {
                btn.backgroundColor = [UIColor yellowColor];
            }
            [self addSubview:btn];
        }
        
        self.backgroundColor = [UIColor redColor];
    }
        
    return self;
}

- (void)btnClick:(UIButton *)sender{
    
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    
    NSLog(@"%@",window.subviews);
    
    CGRect transformRect = [self convertRect:self.bounds toView:window];
    
    if (1 != sender.tag) {
        UITableView *dropMenu = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(transformRect), kScreenWidth, 100)
                                                             style:UITableViewStylePlain];
        dropMenu.delegate = self;
        dropMenu.dataSource = self;
        dropMenu.tag = sender.tag;
        
        [self.showDropMenu removeFromSuperview];
        self.showDropMenu = dropMenu;
        [window addSubview:dropMenu];
    }else{
        NSLog(@"showRegionPick");
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat btnW = kScreenWidth * 0.25;
    
    for (int i = 0; i< self.subviews.count;i++) {
        
        UIView *subView = self.subviews[i];
        subView.height = self.height;
        subView.x = btnW * i;
        subView.y = 0;
        subView.width = btnW;
    }
}

#pragma mark --- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (0 == tableView.tag) return self.serviceTypes.count;
    if (2 == tableView.tag) return self.carTypes.count;
    return self.sortTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    if (0 == tableView.tag) {
        cell.textLabel.text = self.serviceTypes[indexPath.row];
    }else if (2 == tableView.tag)
    {
        cell.textLabel.text = self.carTypes[indexPath.row];
    }else{
        cell.textLabel.text = self.sortTypes[indexPath.row];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDropMenuTableCellClickNotification
                                                        object:nil
                                                      userInfo:@{@"table":tableView,@"TAG":@(tableView.tag),@"STR":(tableView.tag == 0 ? self.serviceTypes[indexPath.row] : tableView.tag == 2 ? self.carTypes[indexPath.row] : self.sortTypes[indexPath.row])}];
    [tableView removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"lalal");
}

@end
