//
//  DYZJoinController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZJoinController.h"
#import "LYTextField.h"
#import "APIJoin.h"


@interface DYZJoinController ()
@property (weak, nonatomic) IBOutlet LYTextField *txtName;
@property (weak, nonatomic) IBOutlet LYTextField *txtGender;
@property (weak, nonatomic) IBOutlet LYTextField *txtPhone;
@property (weak, nonatomic) IBOutlet LYTextField *txtArea;
@property (weak, nonatomic) IBOutlet LYTextField *txtAddress;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBgWidth;


@end

@implementation DYZJoinController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txtName.textLeftOffset = 20;
    _txtGender.textLeftOffset = 20;
    _txtPhone.textLeftOffset = 20;
    _txtArea.textLeftOffset = 20;
    _txtAddress.textLeftOffset = 20;

    _constraintOfBgWidth.constant = kScreenWidth;
}


- (IBAction)didPressedJoin:(id)sender {
    if (!_txtName.text.length ||
        !_txtGender.text.length ||
        !_txtPhone.text.length ||
        !_txtArea.text.length ||
        !_txtAddress.text.length) {
        [self.view makeToast:@"请先填写加盟信息"];
        return;
    }
    APIJoin *request = [APIJoin new];
    request.name = _txtName.text;
    request.sex = _txtGender.text;
    request.telephone = _txtPhone.text;
    request.area = _txtArea.text;
    request.address = _txtAddress.text;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        if (responseObject.resultcode.integerValue == 0) {
            [weakSelf.view makeToast:@"成功，文案待定"];
        } else {
            [weakSelf.view makeToast:responseObject.resultmsg];
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        [weakSelf.view makeToast:error.description];
    }];
}

@end
