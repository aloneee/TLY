//
//  HomeRootViewController.m
//  特洛伊
//
//  Created by liurihua on 15/8/20.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "HomeRootViewController.h"
#import "DDHomeChoseCityViewController.h"
#import "DDHomeAddCarInfoViewController.h"
#import <CoreLocation/CoreLocation.h>

//轮播图
#import "HMNewsCell.h"
#import "HMNews.h"
#import <MJExtension.h>
#import "DDFlowLayout.h"

//按钮点击
#import "DDHomeFreshManViewController.h"
#import "DDHomeSpecificPreferentialViewController.h"
#import "DDHomeRecommendRewardViewController.h"
#import "DDHomeIcePriceViewController.h"
#import "DDHomeMaintenanceViewController.h"

#define HMCellIdentifier @"news"
#define HMMaxSections 100

@interface HomeRootViewController () <UICollectionViewDataSource, UICollectionViewDelegate,CLLocationManagerDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic)   UICollectionView       *collectionView;
@property (weak, nonatomic)   UIPageControl          *pageControl;
@property (nonatomic, strong) NSArray                *newses;
@property (nonatomic, strong) NSTimer                *timer;

@property (nonatomic, weak)   UIButton               *leftNavItem;
@property (nonatomic, strong) CLLocationManager      *locationManager;
@property (nonatomic ,strong) CLGeocoder             *geocoder;

@end

@implementation HomeRootViewController

#pragma mark ---- lazy load
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


- (NSArray *)newses
{
    if (_newses == nil) {
        self.newses = [HMNews objectArrayWithFilename:@"newses.plist"];
        self.pageControl.numberOfPages = self.newses.count;
        NSLog(@"%@",self.newses);
    }
    return _newses;
}


#pragma mark --- life cycle
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.locationManager.delegate = self;
    // 判断是否是iOS8
    if(ios8)
    {
        NSLog(@"是iOS8");
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        [self.locationManager requestAlwaysAuthorization]; // 请求前台和后台定位权限
        [self.locationManager startUpdatingLocation];

    }else
    {
        NSLog(@"是iOS7");
        // 3.开始监听(开始获取位置)
        [self.locationManager startUpdatingLocation];
    }
    
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    left.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [left setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 80, 30);
    [left setTitle:@"北京市" forState:UIControlStateNormal];
    [left addTarget:self
             action:@selector(choseCity)
   forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.leftNavItem = left;
    
    
    
    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    right.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [right setTitleColor:[UIColor whiteColor]
                forState:UIControlStateNormal];
    
    [[DDHomeCarTool getCars] lastObject];
    
    [right setTitle:@"添加爱车" forState:UIControlStateNormal];
    [right addTarget:self
              action:@selector(addCarInfo)
    forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight * 0.25);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavgationBarHeight, kScreenWidth, kScreenHeight * 0.25)
                                                          collectionViewLayout:[[DDFlowLayout alloc] init]];

    collectionView.backgroundColor = [UIColor redColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMNewsCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:HMCellIdentifier];
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                     inSection:HMMaxSections/2]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
    // 添加定时器
    [self addTimer];
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:({
        
        CGRect frame = CGRectMake(kScreenWidth - 120, kScreenHeight * 0.25 - 30 + kNavgationBarHeight, 100, 30);
        frame;
        
    })];
    
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl = pageControl;
    [self.view bringSubviewToFront:self.pageControl];
    
    
    CGFloat middleBtnW = kScreenWidth * 0.25;
    NSArray *MiddleBtnTitles = @[@"新人专区",@"每日整点",@"推荐奖励",@"冰点价格"];
    for (int i = 0; i <MiddleBtnTitles.count; i++) {
        UIButton *middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        middleBtn.frame = CGRectMake(middleBtnW * i, CGRectGetMaxY(self.collectionView.frame) + 10, middleBtnW, kScreenHeight * 0.25);
        middleBtn.backgroundColor = [UIColor blueColor];
        middleBtn.tag = i;
        [middleBtn setTitle:MiddleBtnTitles[i] forState:UIControlStateNormal];
        [middleBtn addTarget:self action:@selector(middleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:middleBtn];
    }
    
    CGFloat bottomBtnW = kScreenWidth * 0.5;
    NSArray *bottomBtnTitles = @[@"维修预约",@"汽车保养"];
    for (int i = 0; i < bottomBtnTitles.count; i++) {
        UIButton *middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        middleBtn.frame = CGRectMake(bottomBtnW * i, kScreenHeight * 0.75 - kTabBarHeight, bottomBtnW, kScreenHeight * 0.25);
        middleBtn.backgroundColor = [UIColor redColor];
        middleBtn.tag = i + 4;
        [middleBtn setTitle:bottomBtnTitles[i] forState:UIControlStateNormal];
        [middleBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:middleBtn];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.leftNavItem.enabled = YES;
}


#pragma mark ---- UICollectionView dataSource & delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return HMMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMCellIdentifier forIndexPath:indexPath];
    
    cell.news = self.newses[indexPath.item];
    
    return cell;
}

/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}


#pragma mark ---- scrollViewDelegate
/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"scrollViewDidEndDragging--松开");
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
    self.pageControl.currentPage = page;
}


#pragma mark ---- helper
-(void)middleBtnClick:(UIButton *)sender{
    
    NSArray *array = @[@"FreshMan",@"SpecificPreferential",@"RecommendReward",@"IcePrice"];
    
    [self.navigationController pushViewController:[[NSClassFromString([NSString stringWithFormat:@"DDHome%@ViewController",array[sender.tag]]) alloc] init]
                                         animated:YES];
}

- (void)bottomBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 4:
            NSLog(@"维修预约");
            break;
        case 5:{
            NSLog(@"汽车保养");
            DDHomeMaintenanceViewController *m = [[UIStoryboard storyboardWithName:@"Main"
                                                                            bundle:nil] instantiateViewControllerWithIdentifier:@"maintenanceRoot"];
            [self.navigationController pushViewController:m
                                                 animated:YES];
        }
            break;
        default:
            break;
    }
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:self
                                                    selector:@selector(nextPage)
                                                    userInfo:nil
                                                     repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer
                              forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item
                                                             inSection:HMMaxSections/2];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem
                                                     inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:YES];
}

#pragma mark ---- 定位相关
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *userLocation = [locations lastObject];
    
    [self.geocoder reverseGeocodeLocation:userLocation
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            
                            CLPlacemark *placemark = [placemarks lastObject];
                            
                            NSLog(@"%@",placemark.administrativeArea);
                            
                            if (placemark.administrativeArea) {
                                [self.leftNavItem setTitle:placemark.administrativeArea
                                                  forState:UIControlStateNormal];
                                [self.locationManager stopUpdatingLocation];
                            }
                        }];
    
}


-(void)choseCity{
    
    DDHomeChoseCityViewController *choseCity = [[DDHomeChoseCityViewController alloc] init];
    choseCity.userLocationBtn = self.leftNavItem;
    [self.navigationController pushViewController:choseCity animated:YES];
    self.leftNavItem.enabled = NO;
    
}

-(void)addCarInfo{
    
    DDHomeAddCarInfoViewController *addCarInfo = [[UIStoryboard storyboardWithName:@"Main"
                                                                            bundle:nil] instantiateViewControllerWithIdentifier:@"addCarInfo"];
    
    [self.navigationController pushViewController:addCarInfo animated:YES];
}



@end
