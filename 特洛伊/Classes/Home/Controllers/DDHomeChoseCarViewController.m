//
//  DDHomeChoseCarViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeChoseCarViewController.h"
#import "DDHomeCar.h"
#import "DDTouchBeginView.h"
#import "DDHomeCarSubNameViewController.h"

static const NSTimeInterval kAnimationDuration = 0.25;

@interface DDHomeChoseCarViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  UITableView           *leftTable;
@property (nonatomic, strong)  UITableView           *rightTable;
@property (nonatomic, strong)  UIView                *trangleView;
@property (nonatomic, strong)  UIView                *rightContainer;
@property (nonatomic, weak  )  UIView                *cover;

@property (nonatomic, strong)  NSMutableDictionary   *brandDict;
@property (nonatomic, strong)  NSMutableArray        *brandArray;
@property (nonatomic, strong)  NSMutableArray        *subBrandArray;

@end

@implementation DDHomeChoseCarViewController


#pragma marhk ---- lazy load
-(UIView *)rightContainer{
    
    if (!_rightContainer) {
        self.rightContainer = ({
            
            __block UIView *rightContainer = [[UIView alloc] initWithFrame:({
                CGRect frame = CGRectMake(kScreen_Width ,
                                          kNavgationBarHeight,
                                          kScreen_Width,
                                          kScreen_Height - kNavgationBarHeight);
                frame;
            })];
            rightContainer.backgroundColor = CLEARCOLOR;
            rightContainer.layer.masksToBounds = NO;
            rightContainer.layer.cornerRadius = 0.0;
            rightContainer.layer.shadowOffset = CGSizeMake(-5.0f, 0.0f);
            rightContainer.layer.shadowRadius = 5.0;
            rightContainer.layer.shadowOpacity = 0.4;
            
            [rightContainer addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
                
                UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)ges;
                
                switch (ges.state) {
                    case UIGestureRecognizerStateChanged:{
                        
                        rightContainer.transform = CGAffineTransformMakeTranslation([pan translationInView:self.view].x, 0);
                        if (rightContainer.transform.tx < 0) {
                            rightContainer.transform = CGAffineTransformIdentity;
                        }
                    }
                        break;
                    case UIGestureRecognizerStateEnded:{
                        
                        if (rightContainer.transform.tx > kScreen_Width * 0.2) {
                            
                            [self removeRight];
                        }else{
                            [UIView animateWithDuration:kAnimationDuration
                                             animations:^{
                                                 rightContainer.transform = CGAffineTransformIdentity;
                                             }];
                        }
                        
                    }
                        
                    default:
                        break;
                }
                
            }]];
            
            [rightContainer addSubview:self.trangleView];
            [rightContainer addSubview:self.rightTable];
            [self.view addSubview:rightContainer];
            
            rightContainer;
            
        });
    }
    return _rightContainer;
}

-(UIView *)trangleView{
    if (!_trangleView) {
        
        _trangleView = [[UIView alloc] init];
        _trangleView.backgroundColor = [UIColor whiteColor];
        _trangleView.width = _trangleView.height = 10;
        _trangleView.transform = CGAffineTransformMakeRotation(M_PI_4);

    }
    return _trangleView;
}

-(NSMutableArray *)subBrandArray{
    if (!_subBrandArray) {
        _subBrandArray = [NSMutableArray array];
    }
    return _subBrandArray;
}

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
                CGRect frame = CGRectMake(0,
                                          kNavgationBarHeight,
                                          kScreen_Width,
                                          kScreen_Height - kNavgationBarHeight - kTabBarHeight);
                frame;
            }) style:UITableViewStylePlain];
            leftTable.delegate = self;
            leftTable.dataSource = self;
            leftTable;
        });
    }
    
    return _leftTable;
}

-(UITableView *)rightTable{
    if (_rightTable == nil) {
        self.rightTable = ({
            UITableView *rightTable= [[UITableView alloc] initWithFrame:({
                CGRect frame = CGRectMake(10,
                                          0,
                                          kScreen_Width,
                                          kScreen_Height - kNavgationBarHeight);
                frame;
            }) style:UITableViewStylePlain];
            rightTable.delegate = self;
            rightTable.dataSource = self;
            rightTable;
        });
    }
    
    return _rightTable;
}


#pragma mark ---- life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择品牌";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self.view addSubview:self.leftTable];
    
    
    [[DDHttpTool sharedTool] POST:DDGetCarBrandsUrl
                       parameters:@{@"parentId":@0}
                          success:^(id responseObject) {
        
        NSLog(@"%@",responseObject[@"result"]);
        
        for (NSString *key in responseObject[@"result"]) {
            
            NSArray *newCars = [DDHomeCar objectArrayWithKeyValuesArray:[responseObject[@"result"] objectForKey:key]];
            
            [self.brandDict setObject:newCars
                               forKey:key];
        }

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
    }else{
        if (self.subBrandArray.count > 0) {
            return self.subBrandArray.count;
        }
        return 10;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    NSLog(@"%@",self.brandArray);
    
    if (tableView == self.leftTable) {
        NSDictionary *d = self.brandArray[indexPath.section];
        NSString *key = [d allKeys][0];
        DDHomeCar *car = [d objectForKey:key][indexPath.row];
        cell.textLabel.text = car.name;
    }else{
        if (self.subBrandArray.count > 0) {
            DDHomeCar *car = self.subBrandArray[indexPath.row];
            cell.textLabel.text = car.name;
        }else{
            cell.textLabel.text = @"";
        }
        
    }
    
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
    if (tableView == self.leftTable) {
        return 30;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTable) {
        
        tableView.scrollEnabled = NO;
        
        UIView *cover = [[UIView alloc] initWithFrame:self.leftTable.bounds];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
            
            [self removeRight];
        }]];
        
        self.cover = cover;
        [self.leftTable addSubview:cover];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGPoint center = cell.center;
        //    
        self.trangleView.center = CGPointMake(10, center.y - tableView.contentOffset.y);
        
        
        NSDictionary *d = self.brandArray[indexPath.section];
        NSString *key = [d allKeys][0];
        DDHomeCar *car = [d objectForKey:key][indexPath.row];
        
        [[DDHttpTool sharedTool] POST:DDGetCarBrandsUrl
                           parameters:@{@"parentId":car.carId}
                              success:^(id responseObject) {
            
            self.subBrandArray = [DDHomeCar objectArrayWithKeyValuesArray:responseObject[@"result"]];
            
            [self.rightTable reloadData];
            
            [UIView animateWithDuration:0.25f animations:^{
                self.rightContainer.x = kScreen_Width * 0.4;

            }];
        }
                              failure:^(NSError *error) {
            
        }];
    }else{
        
        DDHomeCarSubNameViewController *subName = [[DDHomeCarSubNameViewController alloc] init];
        
         DDHomeCar *car = self.subBrandArray[indexPath.row];
        subName.carId = car.carId;
        [self.navigationController pushViewController:subName
                                             animated:YES];
    }
}


#pragma mark --- helper
-(void)removeRight{
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         _rightContainer.transform = CGAffineTransformMakeTranslation(kScreen_Width * 0.6, 0);
                         
                     }
                     completion:^(BOOL finished) {
                         _rightContainer = nil;
                         _rightTable = nil;
                         _trangleView = nil;
                         [_cover removeFromSuperview];
                         _cover = nil;
                         _leftTable.scrollEnabled = YES;
                     }];
}

@end
