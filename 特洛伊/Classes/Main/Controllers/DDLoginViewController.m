//
//  DDLoginViewController.m
//  特洛伊
//
//  Created by liurihua on 15/8/24.
//  Copyright (c) 2015年 刘日华. All rights reserved.
//

#import "DDLoginViewController.h"

@interface DDLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic)   IBOutlet UITextField     *phoneNumberView;
@property (weak, nonatomic)   IBOutlet UITextField     *verificationCodeView;
@property (weak, nonatomic)   IBOutlet UIButton        *loginBtn;
@property (weak, nonatomic)   IBOutlet UIButton        *getVerificationCodeBtn;

@property (nonatomic, strong)          NSTimer         *timer;

@end

static NSTimeInterval kDownCount;

@implementation DDLoginViewController


#pragma mark --- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *hintView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, self.phoneNumberView.height)];
    hintView.text = @"账号:";
    hintView.font = [UIFont systemFontOfSize:14];
    hintView.textAlignment = NSTextAlignmentCenter;
    self.phoneNumberView.leftView = hintView;
    
    self.phoneNumberView.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.phoneNumberView handleControlEvents:UIControlEventAllEditingEvents
                                    withBlock:^(UITextField *weakSender) {
                                        
        
        NSLog(@"%@",weakSender.text);
        
        if (11 == weakSender.text.length) {
            
            [self.getVerificationCodeBtn setTitleColor:[UIColor blueColor]
                                              forState:UIControlStateNormal];
            
            self.getVerificationCodeBtn.enabled = YES;
        }else{
            [self.getVerificationCodeBtn setTitleColor:[UIColor lightGrayColor]
                                              forState:UIControlStateNormal];
            
            self.getVerificationCodeBtn.enabled = NO;
        }
    }];
    
    self.getVerificationCodeBtn.layer.borderWidth = 1;
    self.getVerificationCodeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.getVerificationCodeBtn setTitleColor:[UIColor lightGrayColor]
                                      forState:UIControlStateNormal];
    
    self.getVerificationCodeBtn.enabled = NO;
    self.getVerificationCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.loginBtn.backgroundColor = [UIColor greenColor];
    self.loginBtn.layer.cornerRadius = 5;

    
}

#pragma mark --- helper
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.phoneNumberView resignFirstResponder];
    [self.verificationCodeView resignFirstResponder];
    
}

- (IBAction)getVerificationCode:(id)sender {
    
    [self.phoneNumberView resignFirstResponder];
    
    NSLog(@"上传手机号码:%@",self.phoneNumberView.text);
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"cell"] = self.phoneNumberView.text;
    paras[@"role"] = @8;
//    paras[@"source"] = @;
    
    [[DDHttpTool sharedTool] POST:DDLoginSmsMtUrl
                       parameters:paras
                          success:^(id responseObject) {
                              
        [MBProgressHUD showSuccess:@"验证码已发送到您的手机..."];
                              
    }
                          failure:^(NSError *error) {
                              
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
    
    kDownCount = 60;
    
    [self.getVerificationCodeBtn setTitle:@"60秒"
                                 forState:UIControlStateNormal];
    
    [self.getVerificationCodeBtn setTitleColor:[UIColor blueColor]
                                      forState:UIControlStateNormal];
    
    self.getVerificationCodeBtn.enabled = NO;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                               block:^{
        
        kDownCount--;
        
        if (0 == kDownCount) {
            self.getVerificationCodeBtn.enabled = YES;
            
            [self.getVerificationCodeBtn setTitle:@"重发"
                                         forState:UIControlStateNormal];
            [_timer invalidate];
        }else{
            [self.getVerificationCodeBtn setTitle:[NSString stringWithFormat:@"%.0f秒",kDownCount]
                                         forState:UIControlStateNormal];
        }
    }
                                             repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer
                                 forMode:NSRunLoopCommonModes];
    
}

- (void)countdown{
    
    
}

- (IBAction)login:(id)sender {
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"cell"] = @"18000001921";
    paras[@"role"] = @8;
//    paras[@"source"] = @"000";
    paras[@"smsCode"] = @"7864";
    
    [[DDHttpTool sharedTool] POST:DDLoginSmsUrl
                       parameters:paras
                          success:^(id responseObject) {
                              
        NSLog(@"%@",responseObject);
        
        DDUser *user = [[DDUser alloc] init];
        user.ticket = responseObject[@"data"][@"ticket"];
        [DDUserTool saveUser:user];
        
        
        NSLog(@"%@",[DDUserTool ticket]);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
    NSLog(@"上传手机号:%@ 和 验证码:%@",self.phoneNumberView.text,self.verificationCodeView.text);
    
}
@end
