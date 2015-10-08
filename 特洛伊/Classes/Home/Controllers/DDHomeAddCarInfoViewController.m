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

@interface DDHomeAddCarInfoViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView        *choseCarView;
@property (weak, nonatomic) IBOutlet UIView        *choseYearView;
@property (weak, nonatomic) IBOutlet UIView        *currentKMView;
@property (weak, nonatomic) IBOutlet UIButton      *provinceBtn;
@property (weak, nonatomic) IBOutlet UILabel       *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel       *yearLabel;
@property (weak, nonatomic) IBOutlet UITextField   *KMField;

@property (weak, nonatomic) IBOutlet UITextField   *licensePlateNumberField;
@property (weak, nonatomic) IBOutlet UIButton      *doneBtn;

@property (nonatomic, weak)   DDDatePicker         *datePicker;
@property (nonatomic, copy)   NSString             *carId;

@property (nonatomic, assign) NSUInteger           year;
@property (nonatomic, assign) NSUInteger           month;
@property (nonatomic, weak)   UIView               *cover;
@property (nonatomic, weak)   UIView               *yearContainer;
@property (nonatomic, weak)   UIView               *KMContainer;
@property (nonatomic, strong) NSArray              *provinces;
@property (nonatomic, copy)   NSString             *currentProvince;


@end

static const NSTimeInterval kAnimateDuration = 0.25f;

@implementation DDHomeAddCarInfoViewController

#pragma mark --- lazy load
//-(DDDatePicker *)datePicker{
//    
//    if (!_datePicker) {
//        DDDatePicker *datePicker = [[DDDatePicker alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height * 0.25)
//                                                        datePickerMode:UIDatePickerModeDate
//                                                           minimumDate:nil maximumDate:[NSDate date]];
//
//        datePicker.cancleBlock = ^(DDDatePicker *dp){
//            
//            [UIView animateWithDuration:kAnimateDuration animations:^{
//                dp.transform = CGAffineTransformIdentity;
//                dp.isShow = NO;
//
//            }];
//        };
//        
//        datePicker.doneBlock = ^(DDDatePicker *dp){
//            [UIView animateWithDuration:kAnimateDuration animations:^{
//                dp.transform = CGAffineTransformIdentity;
//                dp.isShow = NO;
//            } completion:^(BOOL finished) {
//                
//                NSDate *date = self.datePicker.date;
//                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//                [dateFormat setDateFormat:@"yyyy-MM"];
////                [self.choseBuyDateBtn setTitle:[dateFormat stringFromDate:date]
////                                      forState:UIControlStateNormal];
//                
//            }];
//        };
//        
//        [self.view addSubview:datePicker];
//        
//        _datePicker = datePicker;
//    }
//    
//    return _datePicker;
//}

-(NSArray *)provinces{
    if (!_provinces) {
        NSArray *provinces = @[@"京",
                               @"沪",
                               @"津",
                               @"渝",
                               @"黑",
                               @"吉",
                               @"辽",
                               @"蒙",
                               @"冀",
                               @"新",
                               @"甘",
                               @"青",
                               @"陕",
                               @"宁",
                               @"豫",
                               @"鲁",
                               @"晋",
                               @"皖",
                               @"鄂",
                               @"湘",
                               @"苏",
                               @"川",
                               @"黔",
                               @"滇",
                               @"桂",
                               @"藏",
                               @"浙",
                               @"赣",
                               @"粤",
                               @"闽",
                               @"台",
                               @"琼",
                               @"港",
                               @"澳"];
        _provinces = provinces;
    }
    return _provinces;
}

-(UIView *)KMContainer{
    if (!_KMContainer) {
        __block UIView *KMContainer = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height * 0.4)];
        KMContainer.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:KMContainer];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.frame = CGRectMake(0, 0, 50, KMContainer.height * 0.2);
        
        [cancle setTitle:@"取消"
                forState:UIControlStateNormal];
        
        [cancle setTitleColor:[UIColor orangeColor]
                     forState:UIControlStateNormal];
        
        [cancle handleControlEvents:UIControlEventTouchUpInside
                          withBlock:^(id weakSender) {
                              
                              [UIView animateWithDuration:kAnimateDuration
                                               animations:^{
                                                   //
                                                   KMContainer.transform = CGAffineTransformIdentity;
                                               }
                                               completion:^(BOOL finished) {
                                                   
                                                   [KMContainer removeFromSuperview];
                                                   KMContainer = nil;
                                               }];
                          }];
        
        [KMContainer addSubview:cancle];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(kScreen_Width - 50, 0, 50, KMContainer.height * 0.2);
        [doneBtn setTitle:@"确定"
                 forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[UIColor orangeColor]
                      forState:UIControlStateNormal];
        
        [doneBtn handleControlEvents:UIControlEventTouchUpInside
                           withBlock:^(id weakSender) {
                               
                               [UIView animateWithDuration:kAnimateDuration
                                                animations:^{
                                                    KMContainer.transform = CGAffineTransformIdentity;
                                                }
                                                completion:^(BOOL finished) {
                                                    
                                                    [KMContainer removeFromSuperview];
                                                    KMContainer = nil;
                                                    
                                                    [self.provinceBtn setTitle:self.currentProvince
                                                                      forState:UIControlStateNormal];
                                                }];
                               
                               
                           }];
        
        [KMContainer addSubview:doneBtn];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KMContainer.height * 0.2, kScreen_Width, KMContainer.height - CGRectGetMaxY(doneBtn.frame))];
        picker.tag = 1;
        picker.dataSource = self;
        picker.delegate = self;
        [KMContainer addSubview:picker];
        
        _KMContainer = KMContainer;

    }
    return _KMContainer;
}

-(UIView *)yearContainer{
    if (!_yearContainer) {
        __block UIView *yearContainer = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height * 0.4)];
        yearContainer.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:yearContainer];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.frame = CGRectMake(0, 0, 50, yearContainer.height * 0.2);
        
        [cancle setTitle:@"取消"
                forState:UIControlStateNormal];
        
        [cancle setTitleColor:[UIColor orangeColor]
                     forState:UIControlStateNormal];
        
        [cancle handleControlEvents:UIControlEventTouchUpInside
                          withBlock:^(id weakSender) {
                              
                              [UIView animateWithDuration:kAnimateDuration
                                               animations:^{
                                                   //
                                                   yearContainer.transform = CGAffineTransformIdentity;
                                               }
                                               completion:^(BOOL finished) {
                                                   
                                                   [yearContainer removeFromSuperview];
                                                   yearContainer = nil;
                                               }];
                          }];
        
        [yearContainer addSubview:cancle];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(kScreen_Width - 50, 0, 50, yearContainer.height * 0.2);
        [doneBtn setTitle:@"确定"
                 forState:UIControlStateNormal];
        
        [doneBtn setTitleColor:[UIColor orangeColor]
                      forState:UIControlStateNormal];
        
        [doneBtn handleControlEvents:UIControlEventTouchUpInside
                           withBlock:^(id weakSender) {
                               
                               [UIView animateWithDuration:kAnimateDuration
                                                animations:^{
                                                    yearContainer.transform = CGAffineTransformIdentity;
                                                }
                                                completion:^(BOOL finished) {
                                                    
                                                    [yearContainer removeFromSuperview];
                                                    yearContainer = nil;
                                                    self.yearLabel.text = [NSString stringWithFormat:@"%ld年%ld月",self.year,self.month];
                                                }];
                               
                               
                           }];
        
        [yearContainer addSubview:doneBtn];
        
        UILabel *yearHint = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(doneBtn.frame), kScreen_Width * 0.5, 10)];
        yearHint.textAlignment = NSTextAlignmentCenter;
        yearHint.text = @"年";
        [yearContainer addSubview:yearHint];
        
        UILabel *monthHint = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width * 0.5, CGRectGetMaxY(doneBtn.frame), kScreen_Width * 0.5, 10)];
        monthHint.textAlignment = NSTextAlignmentCenter;
        monthHint.text = @"月";
        [yearContainer addSubview:monthHint];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, yearContainer.height * 0.2, kScreen_Width, yearContainer.height - CGRectGetMaxY(monthHint.frame))];
        picker.tag = 0;
        picker.dataSource = self;
        picker.delegate = self;
        [yearContainer addSubview:picker];
        
        _yearContainer = yearContainer;
    }
    return _yearContainer;
}

#pragma mark --- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodger];
    
    self.title = @"添加爱车";
    self.year = 0;
    self.month = 0;
    self.currentProvince = @"京";
    
    self.provinceBtn.layer.borderWidth = 2;
    self.provinceBtn.layer.cornerRadius = 5;
    self.provinceBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    
    [self.provinceBtn setTitleColor:[UIColor orangeColor]
                           forState:UIControlStateNormal];
    
    self.doneBtn.backgroundColor = [UIColor orangeColor];
    
    [self.doneBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    
    self.doneBtn.layer.cornerRadius = 5.0f;
    
    [self.choseCarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
        NSLog(@"gotoChoseCar");
        
        DDHomeChoseCarViewController *choseCar = [[DDHomeChoseCarViewController alloc] init];
        
        [self.navigationController pushViewController:choseCar
                                             animated:YES];
    }]];
    
    [self.choseYearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
        NSLog(@"showNumberPicker");
        
        __block UIView *cover = [[UIView alloc] initWithFrame:kScreenBounds];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
            
            [UIView animateWithDuration:kAnimateDuration
                             animations:^{
                                 
                self.yearContainer.transform = CGAffineTransformIdentity;
                                 
            }
                             completion:^(BOOL finished) {
                                 
                [cover removeFromSuperview];
                cover = nil;
            }];
            
        }]];
        [self.view addSubview:cover];
        [self.view insertSubview:cover belowSubview:self.yearContainer];
        
        [UIView animateWithDuration:kAnimateDuration
                         animations:^{
            self.yearContainer.transform = CGAffineTransformMakeTranslation(0, -self.yearContainer.height);
        }];
        
    }]];
    
    [self.provinceBtn handleControlEvents:UIControlEventTouchUpInside
                                withBlock:^(id weakSender) {
                                    
        __block UIView *cover = [[UIView alloc] initWithFrame:kScreenBounds];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionHandler:^(UIGestureRecognizer *ges) {
            
            [UIView animateWithDuration:kAnimateDuration
                             animations:^{
                                 
                                 self.KMContainer.transform = CGAffineTransformIdentity;
                                 
                             }
                             completion:^(BOOL finished) {
                                 
                                 [cover removeFromSuperview];
                                 cover = nil;
                             }];
            
        }]];
        [self.view addSubview:cover];
        [self.view insertSubview:cover belowSubview:self.KMContainer];
        
        [UIView animateWithDuration:kAnimateDuration
                         animations:^{
                             self.KMContainer.transform = CGAffineTransformMakeTranslation(0, -self.KMContainer.height);
                         }];

    }];
    
    [kNote addObserverForName:@"DidSelectCarName"
                       object:nil
                        queue:[NSOperationQueue mainQueue]
                   usingBlock:^(NSNotification * _Nonnull note) {
                       
                       self.nameLabel.text = note.userInfo[@"carName"];

        self.carId = note.userInfo[@"carId"];
    }];
}

-(void)dealloc{
    [kNote removeObserver:self];
}


#pragma mark --- picker dataSource & delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (0 == pickerView.tag) {
        if (0 == component) {
            self.year = row;
        }else{
            self.month = row;
        }
    }else{
        self.currentProvince = self.provinces[row];
    }
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == pickerView.tag) {
        if (0 == component) {
            return 20;
        }else{
            return 12;
        }
    }else{
        return self.provinces.count;
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == pickerView.tag) {
        return [NSString stringWithFormat:@"%ld",row];
    }else{
        return self.provinces[row];
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (0 == pickerView.tag) {
        return 2;
    }else{
        return 1;
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (0 == pickerView.tag) {
        return kScreen_Width * 0.5 ;
    }else{
        return kScreen_Width;
    }
}

#pragma mark ---- helper

//- (IBAction)buyDateBtnClick:(id)sender {
//    NSLog(@"showDatepicker");
//    
//    [self.KMField resignFirstResponder];
//    
//    [self.licensePlateNumberField resignFirstResponder];
//   
//    self.datePicker.isShow = YES;
//    
//    [UIView animateWithDuration:kAnimateDuration
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//        
//        self.datePicker.transform = CGAffineTransformMakeTranslation(0, -(self.datePicker.height + 100));
//        
//    } completion:^(BOOL finished) {
////        [UIView animateWithDuration:kAnimateDuration animations:^{
////            datePicker.transform = CGAffineTransformMakeTranslation(0, 10);
////        } completion:nil];
//    }];
//}

- (IBAction)doneBtnClick:(id)sender {
    
    BOOL isChoseCar = ![self.nameLabel.text isEqualToString:@"请输入车型信息"];
    BOOL isAddKM = self.KMField.text.length != 0;
    BOOL isChoseYear = ![self.yearLabel.text isEqualToString:@"请选择"];
    BOOL isAddLicensePlateNumber = self.licensePlateNumberField.text.length != 0;
    
    if (isChoseYear && isChoseCar && isAddKM && isAddLicensePlateNumber) {
        //save
        
        DDHomeCar *car = [[DDHomeCar alloc] init];
        car.name = self.nameLabel.text;
        car.mileAge= self.KMField.text;
        car.numberOfYear = self.yearLabel.text;
//        car.carStartDate = self.choseBuyDateBtn.titleLabel.text;
        car.carProvinceName = self.provinceBtn.titleLabel.text;
        car.carCardNumber = self.licensePlateNumberField.text;
        car.carId = self.carId;
        
        NSLog(@"%@ll",car);
        
        [DDHomeCarTool saveCar:car];
        
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"carTypeId"] = @([self.carId longLongValue]);
        paras[@"carTypeName"] = car.name;
        paras[@"mileAge"] = @([car.mileAge doubleValue]);
//        paras[@"carStartDate"] = car.carStartDate;
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
            [MBProgressHUD showError:@"请选择车型信息"];
            
        }else if (!isChoseYear) {
            [MBProgressHUD showError:@"请选择车辆年限"];
        }else if (!isAddKM) {
            [MBProgressHUD showError:@"请输入当前里程数"];
        }else if (!isAddLicensePlateNumber){
            [MBProgressHUD showError:@"请输入车牌号码"];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.KMField resignFirstResponder];
    
    [self.licensePlateNumberField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
