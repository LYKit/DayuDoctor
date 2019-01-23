//
//  DYZBaseViewController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZBaseViewController.h"

@interface DYZBaseViewController ()

@end

@implementation DYZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 禁用自动偏移
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;

}
@end
