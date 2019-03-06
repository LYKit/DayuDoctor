//
//  DYZHospitalController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/2.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHospitalController.h"

@interface DYZHospitalController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBgWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfMainHeight;

@end

@implementation DYZHospitalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _constraintOfBgWidth.constant = kScreenWidth;
    
    _constraintOfMainHeight.constant = kScreenHeight * (180.0/568.0);
}





// 预约名师
- (IBAction)didPressedAppointment:(id)sender {

    AXWebViewController *vc = [[AXWebViewController alloc] initWithAddress:kAppointmentURL];
    vc.showsBackgroundLabel = NO;
    vc.navigationType = AXWebViewControllerNavigationBarItem;
    [self.navigationController pushViewController:vc animated:YES];
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
