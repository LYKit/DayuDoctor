//
//  DYZVipRightsController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZVipRightsController.h"

@interface DYZVipRightsController ()
@property (nonatomic, strong) UILabel *hasPromotLabel;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UITextField *codeText;

@end

@implementation DYZVipRightsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"会员权益";
    [self setupView];
}


- (void)setupView {
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(32);
        make.right.mas_equalTo(-32);
    }];
    label.text = @"邀请好友使用，推广码被绑定后双方都活得50积分奖励。绑定你的推广码的人越多活得的奖励会累加。一个用户只能绑定一个推广码";
    
    _hasPromotLabel = [UILabel new];
    _hasPromotLabel.textAlignment = NSTextAlignmentCenter;
    _hasPromotLabel.font = [UIFont systemFontOfSize:15];
    _hasPromotLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:_hasPromotLabel];
    [_hasPromotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    _hasPromotLabel.text = @"您已经推广0人";
    
    _codeLabel = [UILabel new];
    _codeLabel.font = [UIFont systemFontOfSize:15];
    _codeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _codeLabel.text = @"您的推广码 F6PGG0G6";
    [self.view addSubview:_codeLabel];
    [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hasPromotLabel.mas_bottom).mas_equalTo(15);
        make.left.equalTo(label);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [self.view addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_codeLabel);
        make.right.equalTo(label);
    }];
    
    _codeText = [UITextField new];
    _codeText.placeholder = @"请输入对方推广码";
    _codeText.font = [UIFont systemFontOfSize:15];
    _codeText.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:_codeText];
    [_codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(_codeLabel);
    }];
    
    UIButton *bindButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [bindButton setTitle:@"复制" forState:UIControlStateNormal];
    [self.view addSubview:bindButton];
    [bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_codeText);
        make.right.equalTo(label);
    }];
}



@end
