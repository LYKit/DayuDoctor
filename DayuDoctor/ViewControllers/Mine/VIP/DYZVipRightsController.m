//
//  DYZVipRightsController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZVipRightsController.h"
#import "APIRecomcode.h"

@interface DYZVipRightsController ()
@property (nonatomic, strong) UILabel *hasPromotLabel;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) APIRecomcode *request;
@property (nonatomic, strong) ResponseRecomcode *response;

@end

@implementation DYZVipRightsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"会员权益";
    [self setupView];
    _request = [APIRecomcode new];
    
    [_request startGetWithSuccessBlock:^(ResponseRecomcode *responseObject, NSDictionary *options) {
        _response = responseObject;
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}




- (void)setupView {
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    bgView.layer.cornerRadius = 10;
    bgView.backgroundColor = [UIColor colorWithHexString:@"#3d170c"];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    label.text = @"邀请好友一起使用，您的推荐码一旦被新用户绑定，您会获得50积分奖励。使用您的推荐码人数越多，您获得的奖励也会累加。一个用户只能绑定一个推荐码";
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom).mas_offset(30);
    }];
    
    _hasPromotLabel = [UILabel new];
    _hasPromotLabel.textAlignment = NSTextAlignmentCenter;
    _hasPromotLabel.font = [UIFont systemFontOfSize:15];
    _hasPromotLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:_hasPromotLabel];
    [_hasPromotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    _hasPromotLabel.text = @"您已经推广0人";
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.view addSubview:tipLabel];
    tipLabel.text = @"您的推荐码 ";
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hasPromotLabel.mas_bottom).mas_equalTo(15);
        make.left.equalTo(label);
        make.height.mas_equalTo(15);
    }];

    
    _codeLabel = [UILabel new];
    _codeLabel.font = [UIFont systemFontOfSize:15];
    _codeLabel.textColor = [UIColor yellowColor];
    _codeLabel.text = @"F6PGG0G6";
    [self.view addSubview:_codeLabel];
    [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hasPromotLabel.mas_bottom).mas_equalTo(15);
        make.left.equalTo(tipLabel.mas_right);
        make.height.mas_equalTo(15);
    }];
    _codeLabel.text = @"F6PGG0G6";
    
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
        make.left.equalTo(tipLabel);
    }];
    
    UIButton *bindButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [bindButton setTitle:@"复制" forState:UIControlStateNormal];
    [self.view addSubview:bindButton];
    [bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_codeText);
        make.right.equalTo(label);
    }];
}

- (void)copyButtonAction {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _codeLabel.text;
}


@end
