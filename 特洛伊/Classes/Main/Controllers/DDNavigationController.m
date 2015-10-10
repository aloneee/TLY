//
//  DDNavigationController.m
//  特洛伊
//
//  Created by liurihua on 15/8/20.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDNavigationController.h"

@interface DDNavigationController  ()<UIGestureRecognizerDelegate>

@end

@implementation DDNavigationController

#pragma mark --- life cycle
+(void)initialize{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"]
                                       forBarMetrics:UIBarMetricsDefault];
//
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor orangeColor]];
    
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [[UINavigationBar appearance] setTitleTextAttributes:attrs];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIViewController *rootVC = self.viewControllers[0];
//    rootVC.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_sky_f"]];
//    rootVC.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.fullScreenInteractivePopGestureRecognizer = YES;
    
}

#pragma mark --- helper

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
//    viewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_sky_f"]];
//    viewController.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    left.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [left setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    
    left.frame = CGRectMake(0, 0, 40, 40);
    
    [left setImage:[UIImage imageNamed:@"back_btn"]
          forState:UIControlStateNormal];
    
    [left handleControlEvents:UIControlEventTouchUpInside
                    withBlock:^(id weakSender) {
                        
        [self popViewControllerAnimated:YES];
    }];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    [super pushViewController:viewController animated:animated];
    
}

@end
