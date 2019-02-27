//
//  DYZCacheParentController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCacheParentController.h"
#import "DYZCachedListController.h"
#import "DYZCachingListController.h"
#import "YCDownloadUtils.h"

@interface DYZCacheParentController ()
@end

@implementation DYZCacheParentController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下载中心";
    [self configMagic];
}

/// MARK: function
- (void)configMagic {
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.sliderColor = [UIColor blackColor];
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.navigationHeight = 60;

//    self.magicView.navigationHeight = IS_IPHONE_X ? 88.f + 60 : 64 + 60;
//    self.magicView.navigationInset = UIEdgeInsetsMake(IS_IPHONE_X ? 88 : 64, 10, 0, 0);
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    [self.magicView reloadData];
    
    
    [self setupDeviceMemoryLabel];
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    //    [self.magicView addSubview:view];
}

/// MARK: VTMagic'delegate
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return @[@"正在下载", @"下载完成"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0: {
            DYZCachedListController *home = [DYZCachedListController new];
            return home;
        }break;
        case 1: {
            DYZCachingListController *newsList = [DYZCachingListController new];
            return newsList;
        }break;
    }
    return [UIViewController new];
}

- (void)setupDeviceMemoryLabel {
    _memoryLabel = [UILabel new];
    _memoryLabel.text = [self freeDiskSpaceInBytes];
    [self.magicView addSubview:_memoryLabel];
    [_memoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.magicView.navigationView.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_offset(17);
    }];
}


- (NSString *)freeDiskSpaceInBytes {
    NSString *str = [NSString stringWithFormat:@"%@", [YCDownloadUtils fileSizeStringFromBytes:[YCDownloadUtils fileSystemFreeSize]]];
    return [NSString stringWithFormat:@"剩余空间：%@", str];
}

@end
