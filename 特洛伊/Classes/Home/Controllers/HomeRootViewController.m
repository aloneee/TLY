//
//  HomeRootViewController.m
//  特洛伊
//
//  Created by liurihua on 15/8/20.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "HomeRootViewController.h"
#import "DDHomeChoseCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking.h>

@interface HomeRootViewController () <UIScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak)    UIScrollView         *scrollView;
@property (nonatomic, weak)    UIPageControl        *pageControl;
@property (nonatomic, weak)    UIButton             *leftNavItem;

@property (nonatomic, strong)  CLLocationManager    *locationManager;
@property (nonatomic ,strong)  CLGeocoder           *geocoder;


@end

@implementation HomeRootViewController

#pragma mark - 懒加载
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

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
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
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 80, 30);
    [left setTitle:@"北京市" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(choseCity) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.leftNavItem = left;
    
    
    
    UIButton *right=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    right.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right setTitle:@"添加爱车" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(addCarInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight / 3)];
//    scrollView.delegate = self;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *userLocation = [locations lastObject];
    
    [self.geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
        
        NSLog(@"%@",placemark.administrativeArea);
        if (placemark.administrativeArea) {
            [self.leftNavItem setTitle:placemark.administrativeArea forState:UIControlStateNormal];
            [self.locationManager stopUpdatingLocation];
        }
    }];

}

-(void)choseCity{
    
    NSLog(@"choseCity");
    
    DDHomeChoseCityViewController *choseCity = [[DDHomeChoseCityViewController alloc] init];
    choseCity.userLocationBtn = self.leftNavItem;
    [self.navigationController pushViewController:choseCity animated:YES];
    
}

-(void)addCarInfo{
    NSLog(@"addCarInfo");
}

@end
