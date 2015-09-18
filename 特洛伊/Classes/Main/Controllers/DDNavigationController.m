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


+(void)initialize{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [[UINavigationBar appearance] setTitleTextAttributes:attrs];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *rootVC = self.viewControllers[0];
    rootVC.view.backgroundColor = ColorWithHexAlpha(0x000000, 1);
    
    
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target
                                                                          action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)pop{
    
    [self popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
//    viewController.view.backgroundColor = ColorWithHexAlpha(0x000000, 1);
    
    UIButton *left=[UIButton buttonWithType:UIButtonTypeCustom];
    left.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [left setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 40, 40);
    [left setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    
    [left addTarget:self
             action:@selector(pop)
   forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    [super pushViewController:viewController animated:animated];
    
}

@end
