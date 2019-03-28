//
//  DYZUpdatePwdController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZUpdatePwdController.h"
#import "APISendCode.h"
#import "APIUpdatePwd.h"
#import "LYAlertView.h"
#import "DYZMemberManager.h"


static NSInteger const countDownSecond = 60;

@interface DYZUpdatePwdController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtPwdAgain;
@property (weak, nonatomic) IBOutlet UIButton *btnSendCode;

@property (nonatomic, strong) APISendCode *requestCode;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DYZUpdatePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [DYZMemberManager isLogin] ?  @"修改密码" : @"忘记密码";
    _index = 0;
}


- (IBAction)didPressedReturnKeyboard:(id)sender {
    [self.view.window endEditing:YES];
}

- (IBAction)didPressedUpdate:(id)sender {
    [self.view.window endEditing:YES];
    if (!_txtUserName.text.length || !_txtPwd.text.length || !_txtPwdAgain.text.length || !_txtCode.text.length) {
        return;
    }
    if (![_txtPwd.text isEqualToString:_txtPwdAgain.text]) {
        
        return;
    }
    
    APIUpdatePwd *request = [APIUpdatePwd new];
    request.mobile = _txtUserName.text;
    request.validateCode = _txtCode.text;
    request.userpwd = _txtPwdAgain.text;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseUpdatePwd *responseObject, NSDictionary *options) {
        [DYZMemberManager sharedMemberManger].token = responseObject.token;
        [DYZMemberManager saveMemberInfo:weakSelf.txtUserName.text password:weakSelf.txtPwd.text];
        [weakSelf.view makeToast:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}



- (IBAction)didPressedSendCode:(id)sender {
    if (!_txtUserName.text.length) {
        return;
    }
    if (_btnSendCode.isEnabled) {
        self.requestCode.mobile = _txtUserName.text;
        __weak typeof(self) weakSelf = self;
        [self.requestCode startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
            [weakSelf sendCodeCountDown];
        } failBlock:^(LYNetworkError *error, NSDictionary *options) {
            
        }];
    }
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
