//
//  DDHomeMaintenanceViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/17.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDHomeMaintenanceViewController.h"

@interface DDHomeMaintenanceViewController ()

@property (weak, nonatomic) IBOutlet UILabel        *carNameView;
@property (weak, nonatomic) IBOutlet UILabel        *driveYearView;
@property (weak, nonatomic) IBOutlet UILabel        *driveDistanceView;

@property (weak, nonatomic) IBOutlet UIButton       *noAnyCarHintView;

@property (weak, nonatomic) IBOutlet UIView         *carNameContainerView;
@property (weak, nonatomic) IBOutlet UIView         *driveYearContainerView;
@property (weak, nonatomic) IBOutlet UIView         *driveDistanceContainerView;

@property (weak, nonatomic) IBOutlet UIButton       *testReportBtn;
@property (weak, nonatomic) IBOutlet UIButton       *IntelligentMaintenanceBtn;
@property (weak, nonatomic) IBOutlet UIButton       *personalMaintenanceBtn;

@end

@implementation DDHomeMaintenanceViewController

#pragma mark --- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL showNoAnyCarHintView = NO;
    
    self.noAnyCarHintView.layer.cornerRadius = 5;
    
    if (showNoAnyCarHintView) {
        self.carNameContainerView.hidden = YES;
        self.driveDistanceContainerView.hidden = YES;
        self.driveYearContainerView.hidden = YES;
    }else{
        self.noAnyCarHintView.hidden = YES;
    }
    
    [@[self.carNameContainerView,self.driveDistanceContainerView,self.driveYearContainerView] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
            NSLog(@"tapGes");
        }];
        [view addGestureRecognizer:tap];
    }];
    
    
    NSArray *colors = @[[UIColor redColor],[UIColor blueColor],[UIColor orangeColor]];
    
    [@[self.testReportBtn,self.IntelligentMaintenanceBtn,self.personalMaintenanceBtn] enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        [btn setTitleColor:[UIColor whiteColor]
                  forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 5;
        if (showNoAnyCarHintView) {
            
            btn.backgroundColor = [UIColor grayColor];
            btn.enabled = NO;
            
        }else{
            
            btn.backgroundColor = colors[idx];
        }
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark --- helper

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@",segue.identifier);
//    UIViewController *vc = segue.destinationViewController;
    
}

@end
