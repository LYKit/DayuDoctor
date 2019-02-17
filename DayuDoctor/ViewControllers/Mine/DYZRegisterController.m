//
//  DYZRegisterController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRegisterController.h"
#import "DYZLoginController.h"
#import "APIRegister.h"
#import "APISendCode.h"

static NSInteger const countDownSecond = 60;

@interface DYZRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtPwdAgain;
@property (weak, nonatomic) IBOutlet UITextField *txtRecommend;
@property (weak, nonatomic) IBOutlet UIButton *btnSendCode;

@property (nonatomic, strong) APISendCode *requestCode;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation DYZRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _btnSendCode.layer.cornerRadius = 14;
    _btnSendCode.layer.masksToBounds = YES;
    _btnSendCode.layer.borderColor = [UIColor colorWithHexString:@"d4cbb1"].CGColor;
    _btnSendCode.layer.borderWidth = 0.5;
    _index = 0;
}



- (IBAction)didPressedRegister:(id)sender {
    if (!_txtUserName.text.length || !_txtPwd.text.length || !_txtPwdAgain.text.length || !_txtCode.text.length) {
        return;
    }
    
    APIRegister *request = [APIRegister new];
    request.mobile = _txtUserName.text;
    request.validateCode = _txtCode.text;
    request.userpwd = _txtPwdAgain.text;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        if (responseObject.resultcode.integerValue == 0) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (IBAction)didPressedGoLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)didPressedSendCode:(id)sender {
    if (!_txtUserName.text.length) {
        return;
    }
    if (_btnSendCode.isEnabled) {
        self.requestCode.mobile = _txtUserName.text;
        __weak typeof(self) weakSelf = self;
        [self.requestCode startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
            if (responseObject.resultcode.integerValue == 0) {
                [weakSelf sendCodeCountDown];
            }
        } failBlock:^(LYNetworkError *error, NSDictionary *options) {
            
        }];
    }
}

- (IBAction)didPressedReturnKeyboard:(id)sender {
    [self.view.window endEditing:YES];
}


- (void)sendCodeCountDown {
    _btnSendCode.layer.borderColor = [UIColor grayColor].CGColor;
    [_btnSendCode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btnSendCode.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
}

- (void)updateCountDown {
    _index++;
    if (_index == countDownSecond) {
        _btnSendCode.enabled = YES;
        _btnSendCode.layer.borderColor = [UIColor colorWithHexString:@"d4cbb1"].CGColor;
        [_btnSendCode setTitleColor:[UIColor colorWithHexString:@"cabc94"] forState:UIControlStateNormal];
        [_btnSendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else if (_index < 60) {
        NSInteger index = countDownSecond - _index;
        [_btnSendCode setTitle:[NSString stringWithFormat:@"%ld秒",index] forState:UIControlStateNormal];
    }
}


/// MARK: setter/getter
- (APISendCode *)requestCode {
    if (!_requestCode) {
        _requestCode = [APISendCode new];
    }
    return _requestCode;
}



@end
