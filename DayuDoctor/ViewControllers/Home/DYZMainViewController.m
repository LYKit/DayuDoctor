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
#import "DYZFaceTeachController.h"
#import "DYZCacheParentController.h"
#import "DYZQAViewController.h"
#import "DYZSearchController.h"
#import "APIHomeBanner.h"
#import "DYZJoinController.h"
#import "DYZHospitalController.h"
#import "DYZMessageController.h"

typedef enum : NSUInteger {
    enumMagicViewVideo = 0,
    enumMagicViewNews,
    enumMagicViewFaceTeach,
    enumMagicViewQA,
    enumMagicViewJoin,
    enumMagicViewHospital,
} enumMagicViewPage;

@interface DYZMainViewController () <DYZMainHeaderViewDelegate>
@property (nonatomic, strong) DYZMainHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *bannerList;

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)createBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(IS_IPHONE_X ? 88:64);
    }];

}



- (void)loadDefaultData {
    __weak typeof(self) weakSelf = self;
    // Banners
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];

}





/// MARK: getter/setter
- (DYZMainHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [DYZMainHeaderView createFromNib];
        _headerView.delegate = self;
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
    self.magicView.navigationInset = UIEdgeInsetsMake(64, 10, 0, 0);
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    [self.magicView reloadData];
    
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
//    [self.magicView addSubview:view];
}


/// MARK: headerview'delegate
- (void)searchBarDidClick {
    DYZSearchController *searchVC = [DYZSearchController new];
    [self addChildViewController:searchVC];
    [self.view addSubview:searchVC.view];
    [searchVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    searchVC.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        searchVC.view.alpha = 1;
    }];
}


- (void)downloadDidClick {
    DYZCacheParentController *vc = [DYZCacheParentController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

- (void)messageDidClick {
    DYZMessageController *vc = [DYZMessageController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}



/// MARK: VTMagic'delegate
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return @[@"课程",@"资讯",@"面授",@"答疑",@"加盟",@"医馆"];
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
        case enumMagicViewVideo: {
            DYZHomeViewController *home = [DYZHomeViewController new];
            return home;
        }break;
        case enumMagicViewNews: {
            DYZNewsTableController *newsList = [DYZNewsTableController new];
            return newsList;
        }break;
        case enumMagicViewFaceTeach: {
            DYZFaceTeachController *vc = [DYZFaceTeachController new];
            return vc;
        }break;
        case enumMagicViewQA: {
            DYZQAViewController *vc = [DYZQAViewController new];
            return vc;
        }break;
        case enumMagicViewJoin: {
            DYZJoinController *vc = [[DYZJoinController alloc] init];
            return vc;
        }break;
        case enumMagicViewHospital: {
            DYZHospitalController *vc = [DYZHospitalController new];
            return vc;
        }break;
        default:
            break;
    }
    return [UIViewController new];
}

@end
