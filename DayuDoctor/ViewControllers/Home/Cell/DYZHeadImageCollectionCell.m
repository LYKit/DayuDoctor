//
//  DYZHeadImageCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHeadImageCollectionCell.h"
#import "SDCycleScrollView.h"


@interface DYZHeadImageCollectionCell ()
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation DYZHeadImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.headerImage.image = [UIImage imageNamed:@"homeHeader"];
    [self createBaseView];
}

- (void)createBaseView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView new];
    [self.contentView addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
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


@end
