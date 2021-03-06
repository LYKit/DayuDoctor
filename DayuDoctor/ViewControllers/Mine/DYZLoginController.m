//
//  DYZLoginController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZLoginController.h"
#import "DYZRegisterController.h"
#import "DYZUpdatePwdController.h"
#import "DYZMemberManager.h"
#import "APILogin.h"
#import "DYZWebViewController.h"

@interface DYZLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation DYZLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    _txtUserName.layer.borderColor = [UIColor grayColor].CGColor;
    _txtUserName.layer.masksToBounds = YES;
    _txtUserName.layer.cornerRadius = 1;
    
    _txtPassword.layer.borderColor = [UIColor grayColor].CGColor;
    _txtPassword.layer.masksToBounds = YES;
    _txtPassword.layer.cornerRadius = 1;
}

- (IBAction)didPressedReturnKeyboard:(id)sender {
    [self.view.window endEditing:YES];
}


- (IBAction)didPressedLogin:(id)sender {
    [self.view.window endEditing:YES];
    APILogin *request = [APILogin new];
    request.mobile = _txtUserName.text;
    request.userpwd = _txtPassword.text;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseLogin *responseObject, NSDictionary *options) {
        [DYZMemberManager sharedMemberManger].token = responseObject.token;
        [DYZMemberManager saveMemberInfo:weakSelf.txtUserName.text password:weakSelf.txtPassword.text];
        [DYZMemberManager loginSuccess];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (IBAction)didPressedFind:(id)sender {
    [self.navigationController pushViewController:[DYZUpdatePwdController new] animated:YES];
}

- (IBAction)didPressedRegister:(id)sender {
    [self.navigationController pushViewController:[DYZRegisterController new] animated:YES];
}

- (IBAction)pirvateProDidClick:(UIButton *)sender {
    NSString *url = @"http://dy.dyzy58.com.cn/";
    DYZWebViewController *vc = [[DYZWebViewController alloc] initWithWebUrlString:url];
    vc.fromController = self;
    vc.showsBackgroundLabel = NO;
    vc.showsToolBar = NO;
    vc.navigationType = AXWebViewControllerNavigationBarItem;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
