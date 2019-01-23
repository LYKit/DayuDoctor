//
//  DYZMainViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainViewController.h"
#import "DYZNewsTableController.h"
#import "YYKit.h"
#import "DYZMainHeaderView.h"
#import "DYZHomeViewController.h"

@interface DYZMainViewController ()
@property (nonatomic, strong) DYZMainHeaderView *headerView;

@end

@implementation DYZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBaseView];
    [self configMagic];
    [self loadDefaultData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)createBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];

}

- (void)loadDefaultData {
    
}



/// MARK: getter/setter
- (DYZMainHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [DYZMainHeaderView createFromNib];
    }
    return _headerView;
}


/// MARK: function
- (void)configMagic {
    self.magicView.navigationColor = [UIColor colorWithHexString:@"#3d170c"];
    self.magicView.sliderColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.navigationHeight = IS_IPHONE_X ? 88.f+60 : 64+60;
    self.magicView.navigationInset = UIEdgeInsetsMake(IS_IPHONE_X ? 88:64, 10, 0, 0);
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    [self.magicView reloadData];
}


/// MARK: VTMagic'delegate
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return @[@"首页",@"视频",@"资讯",@"面授",@"答疑"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0: {
            DYZHomeViewController *home = [DYZHomeViewController new];
            return home;
        }break;
        case 1: {
            
        }break;
        case 2: {
            DYZNewsTableController *newsList = [DYZNewsTableController new];
            return newsList;
        }break;
        case 3: {

        }break;
        case 4: {
            
        }break;
        default:
            break;
    }
    return [UIViewController new];
}

@end
