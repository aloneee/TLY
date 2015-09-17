//
//  DDHomeChoseCarViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/15.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeChoseCarViewController.h"
#import "SkyAssociationMenuView.h"
@interface DDHomeChoseCarViewController ()<SkyAssociationMenuViewDelegate>

@end

@implementation DDHomeChoseCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavgationBarHeight)];
    [self.view addSubview:view];
    SkyAssociationMenuView *choseCarMenu = [[SkyAssociationMenuView alloc] init];
    choseCarMenu.delegate = self;
    
    [choseCarMenu showAsDrawDownView:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveChosedCar) name:@"CHOSECARFINISHED" object:nil];
    
}

-(void)haveChosedCar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)assciationMenuView:(SkyAssociationMenuView*)asView countForClass:(NSInteger)idx {
//    NSLog(@"choose %ld", idx);
    return 10;
}

- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
//    NSLog(@"title %ld", idx_1);
    return [NSString stringWithFormat:@"title %ld", idx_1];
}

-(UIImage *)assciationMenuView:(SkyAssociationMenuView *)asView imageForClass_1:(NSInteger)idx_1{
    return [UIImage imageNamed:@"icon_chose_arrow_sel@2x"];
}

- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
//    NSLog(@"title %ld, %ld", idx_1, idx_2);
    return [NSString stringWithFormat:@"title %ld, %ld", idx_1, idx_2];
}

- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3 {
//    NSLog(@"title %ld, %ld, %ld", idx_1, idx_2, idx_3);
//    [self.navigationController popViewControllerAnimated:YES];
    return [NSString stringWithFormat:@"%ld,%ld,%ld", idx_1, idx_2, idx_3];
}



@end
