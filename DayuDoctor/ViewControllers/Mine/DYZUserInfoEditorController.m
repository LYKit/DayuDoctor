//
//  DYZUserInfoEditorController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/15.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZUserInfoEditorController.h"
#import "APIUpdateUserInfo.h"
#import "APIUserInfo.h"
#import "LXFPhotoHelper.h"
#import "APIUploadImg.h"
#import "ShowPickerView.h"

@interface DYZUserInfoEditorController ()  <ShowPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtGoodtypes;

@property (nonatomic, strong) ResponseUserInfo *responseUserInfo;
@property (nonatomic, strong) UIImage *selectImage;


@end

@implementation DYZUserInfoEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
 
    [self loadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [[APIUserInfo new] startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseUserInfo = responseObject;
        [weakSelf loadDefaultData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)loadDefaultData {
    if (_responseUserInfo.detail.name.length) {
        _txtName.text = _responseUserInfo.detail.name;
    }
    if (_responseUserInfo.detail.telephone.length) {
        _txtPhone.text = _responseUserInfo.detail.telephone;
    }
    if (_responseUserInfo.detail.email.length) {
        _txtEmail.text = _responseUserInfo.detail.email;
    }
    if (_responseUserInfo.detail.address.length) {
        _txtAddress.text = _responseUserInfo.detail.address;
    }
    if (_responseUserInfo.detail.goodtypes.length) {
        _txtGoodtypes.text = _responseUserInfo.detail.goodtypes;
    }
}

- (IBAction)didPressedSubmit:(id)sender {
    APIUploadImg *upload = [APIUploadImg new];
//    upload.upIMG = self.selectImage;
    upload.file = UIImageJPEGRepresentation(self.selectImage,0.1f);
//    upload.fileName = @"1.jpg";
//    upload.mimeType = @"image/jpeg";
    
//    upload.Value = UIImageJPEGRepresentation(self.selectImage,0.1f);
//    upload.key = @"userPhoto";
//    upload.form = @"image/jpeg";
    
    [upload startUpLoadImgWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        
    } progress:^(NSProgress *uploadProgress) {
        
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
//    APIUpdateUserInfo *request = [APIUpdateUserInfo new];
//    request.name = _txtName.text;
//    request.telephone = _txtPhone.text;
//    request.email = _txtEmail.text;
//    request.address = _txtAddress.text;
//    request.goodtypes = _txtGoodtypes.text;
//    request.img = @"123";
//#warning  需处理
//    __weak typeof(self) weakSelf = self;
//    [request startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"perfectInformation" object:nil];
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
//
//    }];
}

- (IBAction)didPressedReturnKeyboard:(id)sender {
    [self.view.window endEditing:YES];
}

- (IBAction)didPressedPhoto:(id)sender {
    __weak typeof(self) weakSelf = self;
    [[LXFPhotoHelper creatWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary config:nil] getSourceWithSelectImageBlock:^(id data) {
        [weakSelf selectedImage:data];
        weakSelf.selectImage = data;
    }];
    
}

- (void)selectedImage:(UIImage *)image {
    _imgPhoto.image = image;
}


- (IBAction)didPressedCity:(id)sender {
    ShowPickerView *areaPickerView = [[ShowPickerView alloc] initWithFrame:self.view.bounds];
    areaPickerView.delegate = self;
    [areaPickerView showPicker];
    [self.view endEditing:YES];
}

#pragma mark == ShowPickerViewDelegate
- (void)showPickerViewDone:(NSString *)chooseTitle chooseId:(NSString *)chooseId
{
    _txtAddress.text = chooseTitle;
}
@end
