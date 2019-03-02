//
//  DYZJoinController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZJoinController.h"
#import "LYTextField.h"


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
    
    
}

@end
