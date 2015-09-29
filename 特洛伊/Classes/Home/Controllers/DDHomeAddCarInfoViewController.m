//
//  DDHomeAddCarInfoViewController.m
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeAddCarInfoViewController.h"
#import "DDHomeChoseCarViewController.h"
#import "DDHomeCar.h"
#import "DDHomeCarTool.h"
#import "DDDatePicker.h"

@interface DDHomeAddCarInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField    *currentKMField;
@property (weak, nonatomic) IBOutlet UITextField    *licensePlateNumberField;
@property (weak, nonatomic) IBOutlet UIButton       *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton       *choseCarBtn;
@property (weak, nonatomic) IBOutlet UIButton       *choseYearBtn;
@property (weak, nonatomic) IBOutlet UIButton       *choseBuyDateBtn;

@property (nonatomic, weak) DDDatePicker            *datePicker;


@property(nonatomic, copy)  NSString                *carId;

@end

static const NSTimeInterval kAnimateDuration = 0.25f;

@implementation DDHomeAddCarInfoViewController

#pragma mark --- lazy load
-(DDDatePicker *)datePicker{
    
    if (!_datePicker) {
        DDDatePicker *datePicker = [[DDDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight * 0.25)
                                                        datePickerMode:UIDatePickerModeDate
                                                           minimumDate:nil maximumDate:[NSDate date]];

        datePicker.cancleBlock = ^(DDDatePicker *dp){
            
            [UIView animateWithDuration:kAnimateDuration animations:^{
                dp.transform = CGAffineTransformIdentity;
                dp.isShow = NO;

            }];
        };
        
        datePicker.doneBlock = ^(DDDatePicker *dp){
            [UIView animateWithDuration:kAnimateDuration animations:^{
                dp.transform = CGAffineTransformIdentity;
                dp.isShow = NO;
            } completion:^(BOOL finished) {
                
                NSDate *date = self.datePicker.date;
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM"];
                [self.choseBuyDateBtn setTitle:[dateFormat stringFromDate:date]
                                      forState:UIControlStateNormal];
                
            }];
        };
        
        [self.view addSubview:datePicker];
        
        _datePicker = datePicker;
    }
    
    return _datePicker;
}

#pragma mark --- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodger];
    
    self.title = @"添加爱车";
    
    self.doneBtn.backgroundColor = [UIColor orangeColor];
    
    [self.doneBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    
    self.doneBtn.layer.cornerRadius = 5.0f;
    
    self.choseCarBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.choseCarBtn.layer.borderWidth = 1;
    self.choseCarBtn.layer.cornerRadius = 5;
    self.choseCarBtn.titleLabel.numberOfLines = 0;
    [self.choseCarBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [kNote addObserverForName:UIKeyboardWillShowNotification
                       object:nil
                        queue:[NSOperationQueue mainQueue]
                   usingBlock:^(NSNotification * _Nonnull note) {
                       
        if (self.datePicker.isShow) {
            
            [UIView animateWithDuration:kAnimateDuration animations:^{
                self.datePicker.transform = CGAffineTransformIdentity;
                self.datePicker.isShow = NO;
            }];
        }
    }];
    
    [kNote addObserverForName:@"DidSelectCarName"
                       object:nil
                        queue:[NSOperationQueue mainQueue]
                   usingBlock:^(NSNotification * _Nonnull note) {
        
        [self.choseCarBtn setTitle:note.userInfo[@"carName"]
                          forState:UIControlStateNormal];
        
        self.carId = note.userInfo[@"carId"];
    }];
}

-(void)dealloc{
    [kNote removeObserver:self];
}

#pragma mark ---- helper
- (IBAction)choseCarBtnClick:(id)sender {
    
    NSLog(@"gotoChoseCar");
    
    DDHomeChoseCarViewController *choseCar = [[DDHomeChoseCarViewController alloc] init];
    
    [self.navigationController pushViewController:choseCar
                                         animated:YES];
}

- (IBAction)choseCurrentNumOfYeayBtnClick:(id)sender {
    NSLog(@"showNumberPicker");
    
    
    
}
- (IBAction)buyDateBtnClick:(id)sender {
    NSLog(@"showDatepicker");
    
    [self.currentKMField resignFirstResponder];
    
    [self.licensePlateNumberField resignFirstResponder];
   
    self.datePicker.isShow = YES;
    
    [UIView animateWithDuration:kAnimateDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        
        self.datePicker.transform = CGAffineTransformMakeTranslation(0, -(self.datePicker.height + 100));
        
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:kAnimateDuration animations:^{
//            datePicker.transform = CGAffineTransformMakeTranslation(0, 10);
//        } completion:nil];
    }];
    
}

- (IBAction)doneBtnClick:(id)sender {
    
    BOOL isChoseCar = ![self.choseCarBtn.titleLabel.text isEqualToString:@"请选择品牌"];
    BOOL isAddKM = self.currentKMField.text.length != 0;
    BOOL isChoseYear = ![self.choseYearBtn.titleLabel.text isEqualToString:@"请选择车辆年限 "];
    
    if (isChoseYear && isChoseCar && isAddKM ) {
        //save
        
        DDHomeCar *car = [[DDHomeCar alloc] init];
        car.name = self.choseCarBtn.titleLabel.text;
        car.mileAge= self.currentKMField.text;
        car.numberOfYear = self.choseYearBtn.titleLabel.text;
        car.carStartDate = self.choseBuyDateBtn.titleLabel.text;
        car.carProvinceName = [self.licensePlateNumberField.text substringToIndex:1];
        car.carCardNumber = [self.licensePlateNumberField.text substringFromIndex:1];
        car.carId = self.carId;
        
        NSLog(@"%@ll",car);
        
        [DDHomeCarTool saveCar:car];
        
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"carTypeId"] = @([self.carId longLongValue]);
        paras[@"carTypeName"] = car.name;
        paras[@"mileAge"] = @([car.mileAge doubleValue]);
        paras[@"carStartDate"] = car.carStartDate;
        paras[@"ticket"] = [DDUserTool ticket];
        paras[@"carProvinceName"] = car.carProvinceName;
        paras[@"carCardNumber"] = car.carCardNumber;
        
        
        NSLog(@"%@",paras);
        
        [[DDHttpTool sharedTool] POST:DDAddMyCarUrl
                           parameters:paras
                              success:^(id responseObject) {
                                  
            NSLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"%@",error.localizedDescription);
        }];
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        if (!isChoseCar){
            [self.choseCarBtn setTitleColor:[UIColor redColor]
                                   forState:UIControlStateNormal];
        }
        
        if (!isChoseYear) {
            [self.choseYearBtn setTitleColor:[UIColor redColor]
                                    forState:UIControlStateNormal];
        }
        
        if (!isAddKM) {
            
            NSMutableAttributedString *attrPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"当前公里数(km)"];
            
            [attrPlaceholder setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                                     range:NSMakeRange(0, attrPlaceholder.length)];
            
            self.currentKMField.attributedPlaceholder = attrPlaceholder;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.currentKMField resignFirstResponder];
    
    [self.licensePlateNumberField resignFirstResponder];
}

@end
