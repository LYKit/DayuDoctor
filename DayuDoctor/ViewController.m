//
//  ViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/15.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "ViewController.h"
#import "DYZNewsTableController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DYZNewsTableController *vc = [DYZNewsTableController new];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

@end
