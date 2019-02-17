//
//  DYZApplyController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZApplyController.h"
#import "DYZLoginController.h"
#import "DYZRegisterController.h"
#import "DYZUpdatePwdController.h"

@interface DYZApplyController ()




@end

@implementation DYZApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报名";
    self.view.backgroundColor = [UIColor whiteColor];
}


- (IBAction)didPressedLogin:(id)sender {
    [self.navigationController pushViewController:[DYZLoginController new] animated:YES];
}

- (IBAction)didPressedRegister:(id)sender {
    [self.navigationController pushViewController:[DYZRegisterController new] animated:YES];
}

- (IBAction)update:(id)sender {
    [self.navigationController pushViewController:[DYZUpdatePwdController new] animated:YES];

}


@end
