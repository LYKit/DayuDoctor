//
//  DYZApplyController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZApplyController.h"
#import "APISignUpDetail.h"
#import "DYZUserInfoEditorController.h"


@interface DYZApplyController ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblGood;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblRemark;
@property (weak, nonatomic) IBOutlet UIView *bgPerfect;
@property (weak, nonatomic) IBOutlet UIButton *btnBgPerfect;
@property (weak, nonatomic) IBOutlet UIButton *btnApply;

@property (nonatomic, strong) SignUpDetail *detail;


@end

@implementation DYZApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报名";
    _bgPerfect.hidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"perfectInformation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kLoginSuccesStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kOutLoginSuccesStatus object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
    if ([DYZMemberManager isLogin]) {
        __weak typeof(self) weakSelf = self;
        [[APISignUpDetail new] startPostWithSuccessBlock:^(ResponseSignUpDetail *responseObject, NSDictionary *options) {
            weakSelf.detail = responseObject.detail;
            [weakSelf refreshData];
        } failBlock:^(LYNetworkError *error, NSDictionary *options) {
            [weakSelf refreshData];
        }];
    } else {
        [self refreshData];
    }
}

- (void)refreshData {
    _lblName.text = _detail.name;
    _lblPhone.text = _detail.telephone;
    _lblAddress.text = _detail.address;
    _lblEmail.text = _detail.email;
    _lblGood.text = _detail.goodtypes;
    _lblMoney.text = [NSString stringWithFormat:@"报名费：%@",_detail.amount];
    _lblRemark.text = _detail.remark.length ? [NSString stringWithFormat:@"备注：%@",_detail.remark] : @"备注：擅长科目为报名科目";
    _bgPerfect.hidden = YES;
    if ([_detail.flag isEqualToString:@"0"]) {
        _bgPerfect.hidden = NO;
        [_btnBgPerfect setTitle:@"点击这里完善资料" forState:UIControlStateNormal];
    } else if (![DYZMemberManager isLogin]) {
        _bgPerfect.hidden = NO;
        [_btnBgPerfect setTitle:@"点击前往登录" forState:UIControlStateNormal];
    }
    
    if ([_detail.signup boolValue]) {
        [_btnApply setTitle:@"已报名" forState:UIControlStateNormal];
        [_btnApply setBackgroundColor:[UIColor colorWithHexString:@"d7d7d7"]];
        _btnApply.enabled = NO;
    }
}

- (IBAction)didPressApply:(id)sender {
    [self openWebPageWithUrlString:_detail.payUrl];
}

- (IBAction)didPressedperfect:(id)sender {
    if ([DYZMemberManager isLogin]) {
        DYZUserInfoEditorController *vc = [DYZUserInfoEditorController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [tab setSelectedIndex:3];
    }
}

@end
