//
//  DYZHeadImageCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHeadImageCell.h"
#import "SDCycleScrollView.h"
#import "DYZCurrentController.h"

@interface DYZHeadImageCell () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation DYZHeadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self createBaseView];
}

- (void)createBaseView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView new];
    [self.contentView addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.currentPageDotColor = [UIColor blackColor];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    self.cycleScrollView = cycleScrollView;
}


- (void)setBannerList:(NSMutableArray *)bannerList {
    _bannerList = bannerList;
    NSMutableArray *urlArray = [NSMutableArray array];
    for (BannerModel *model in _bannerList) {
        [urlArray addObject:model.url];
    }
    self.cycleScrollView.imageURLStringsGroup = urlArray;
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BannerModel *model = _bannerList[index];
    [[DYZCurrentController currentViewController] openRouteURLString:model.jumpUrl options:nil];
}



@end
