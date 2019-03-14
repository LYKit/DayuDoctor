//
//  DYZHospitalController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/2.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHospitalController.h"
#import "APIHomeBanner.h"
#import "DYZHeadImageView.h"

@interface DYZHospitalController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBgWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfMainHeight;
@property (weak, nonatomic) IBOutlet DYZHeadImageView *headImageView;

@end

@implementation DYZHospitalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _constraintOfBgWidth.constant = kScreenWidth;
    
    _constraintOfMainHeight.constant = kScreenHeight * (180.0/568.0);
    
    // Banners
    __weak typeof(self) weakSelf = self;
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"14";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.headImageView.bannerList = responseObject.banners;
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}





// 预约名师
- (IBAction)didPressedAppointment:(id)sender {
    [self openWebPageWithUrlString:kAppointmentURL];
}

// 医馆介绍
- (IBAction)didPressedIntroduce:(id)sender {
    [self openWebPageWithUrlString:kAboutURL];
}

// 医馆加盟
- (IBAction)didPressedJoin:(id)sender {
    [self openWebPageWithUrlString:kHospitalJoinURL];
}

// 高端服务
- (IBAction)didPressedNBServe:(id)sender {
    [self openWebPageWithUrlString:kNBServeURL];
}

// 特殊服务
- (IBAction)didPressedSexServe:(id)sender {
    [self openWebPageWithUrlString:kSexServeURL];
}

// 线上急症
- (IBAction)didPressedemergency:(id)sender {
    [self openWebPageWithUrlString:kChatURL];
}



@end
