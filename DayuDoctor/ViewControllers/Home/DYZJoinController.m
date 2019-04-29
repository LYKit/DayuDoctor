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
#import "ShowPickerView.h"
#import "APIHomeBanner.h"
#import "DYZHeadImageView.h"


@interface DYZJoinController () <ShowPickerViewDelegate>
@property (weak, nonatomic) IBOutlet LYTextField *txtName;
@property (weak, nonatomic) IBOutlet LYTextField *txtGender;
@property (weak, nonatomic) IBOutlet LYTextField *txtPhone;
@property (weak, nonatomic) IBOutlet LYTextField *txtArea;
@property (weak, nonatomic) IBOutlet LYTextField *txtAddress;
@property (weak, nonatomic) IBOutlet DYZHeadImageView *headImageView;

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
    
    // Banners
    __weak typeof(self) weakSelf = self;
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"15";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.headImageView.bannerList = responseObject.banners;
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (IBAction)didPressedJoin:(id)sender {
    [self.view.window endEditing:YES];

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
        [weakSelf.view makeToast:@"提交成功"];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (IBAction)didPressedReturnKeyboard:(id)sender {
    [self.view endEditing:YES];
}




- (IBAction)didPressedCity:(id)sender {
    ShowPickerView *areaPickerView = [[ShowPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    areaPickerView.delegate = self;
    [areaPickerView showPicker];
    [self.view endEditing:YES];
}

#pragma mark == ShowPickerViewDelegate
- (void)showPickerViewDone:(NSString *)chooseTitle chooseId:(NSString *)chooseId
{
    _txtArea.text = chooseTitle;
}
@end
