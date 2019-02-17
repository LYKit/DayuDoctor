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
    [self setupView];
}


- (void)setupView {
    UILabel *label = [UILabel new];
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
        make.top.mas_equalTo(label);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    
    

}



@end
