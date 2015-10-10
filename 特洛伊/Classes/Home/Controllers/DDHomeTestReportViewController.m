//
//  DDHomeTestReportViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/17.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeTestReportViewController.h"
#import "DDHomeMaintenanceDetailViewController.h"


//add ECELL
#import "DDHomeECViewController.h"


@interface DDContainerView : UIView

@property (nonatomic, strong) NSArray *items;

@end

@implementation DDContainerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *left = [[UILabel alloc] init];
        left.text = @"保养项目";
        left.textAlignment = NSTextAlignmentLeft;
        [self addSubview:left];
        
        UILabel *right = [[UILabel alloc] init];
        right.text = @"项目说明";
        right.textAlignment = NSTextAlignmentLeft;
        [self addSubview:right];
        self.height = 30;
    }
    return self;
}

-(void)setItems:(NSArray *)items{
    [items enumerateObjectsUsingBlock:^(NSString *s, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *left = [[UILabel alloc] init];
        left.text = s;
        left.textColor = [UIColor lightGrayColor];
        left.textAlignment = NSTextAlignmentLeft;
        [self addSubview:left];
        
        UILabel *right = [[UILabel alloc] init];
        right.text = s;
        right.textColor = [UIColor lightGrayColor];
        right.textAlignment = NSTextAlignmentLeft;
        [self addSubview:right];
        
        self.height += 30;
        
    }];
}

-(void)layoutSubviews{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.x = 10 + idx % 2 * self.width * 0.5;
        obj.y = idx / 2 * 30;
        obj.width = self.width * 0.5;
        obj.height = 30;
    }];
}

@end

@interface DDHomeTestReportViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentKMView;

@end

@implementation DDHomeTestReportViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"检测报告";
    
    UILabel *KM = [[UILabel alloc] init];
    KM.textColor = [UIColor orangeColor];
    KM.text = @"1000";
    KM.x = CGRectGetMaxX(self.currentKMView.frame);
    KM.y = self.currentKMView.y;
    [KM sizeToFit];
    [self.view addSubview:KM];
    
    UILabel *KMHint = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(KM.frame), KM.y, 100, KM.height)];
    KMHint.text = @"公里";
    KMHint.textAlignment = NSTextAlignmentLeft;
    KMHint.textColor = [UIColor lightGrayColor];
    [self.view addSubview:KMHint];
    
    UILabel *recommentKM = [[UILabel alloc] init];
    recommentKM.text = @"5000";
    recommentKM.textColor = [UIColor orangeColor];
    recommentKM.font = [UIFont systemFontOfSize:50];
    [recommentKM sizeToFit];
    recommentKM.center = CGPointMake(kScreen_Width * 0.5 - 20, CGRectGetMaxY(KM.frame) + 100);
    [self.view addSubview:recommentKM];
    
    UILabel *KMHint2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(recommentKM.frame) + 5, recommentKM.y, 40, recommentKM.height)];
    KMHint2.text = @"公里";
    KMHint2.textAlignment = NSTextAlignmentLeft;
//    KMHint2.textColor = [UIColor lightGrayColor];
    [self.view addSubview:KMHint2];
    
    UILabel *hint = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recommentKM.frame), kScreen_Width, 20)];
    hint.textAlignment = NSTextAlignmentCenter;
    hint.text = @"本次保养推荐里程数";
    hint.font = [UIFont systemFontOfSize:12];
    hint.textColor = [UIColor lightGrayColor];
    [self.view addSubview:hint];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hint.frame) + 50, kScreen_Width, 50)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    UILabel *recommentSug = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width, 50)];
    recommentSug.text = @"厂家保养建议:";
    recommentSug.textAlignment = NSTextAlignmentLeft;
    [lineView addSubview:recommentSug];
    
    DDContainerView *container = [[DDContainerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), kScreen_Width, 0)];
    
    container.items = @[@"更换机油",@"更换机油路氢气",@"更换机油",@"更换机油路氢气",@"更换机油",@"更换机油路氢气"];
    
    [self.view addSubview:container];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, CGRectGetMaxY(container.frame) + 20, kScreen_Width - 100, 50);
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"去保养"
         forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor]
              forState:UIControlStateNormal];
    
    [btn handleControlEvents:UIControlEventTouchUpInside
                   withBlock:^(id weakSender) {
                       
                       DDHomeECViewController *ec = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeEC"];
                       
                       [self.navigationController pushViewController:ec
                                                            animated:YES];
    }];
    
    [self.view addSubview:btn];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --- helper

@end
