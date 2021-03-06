//
//  DYZHomeViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHomeViewController.h"
#import "DYZClassifyCollectionCell.h"
#import "DYZVideoCollectionCell.h"
#import "DYZNewsRollCollectionCell.h"
#import "DYZHeadImageCollectionCell.h"
#import "DYZVideoReusableView.h"
#import "APIClassify.h"
#import "APIHomeCourseList.h"
#import "APIHomeBanner.h"
#import "APINewsList.h"
#import "DYZClassCourseController.h"//分类课程列表
#import "DYZHomeBannerCell.h"

typedef enum : NSUInteger {
    enumHeaderImageSection,
    enumNewsRollSection,
    enumBannerSection,
    enumClassifySection,
    enumVideoRecommendSection
} enumSectionType;

@interface DYZHomeViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) DYZNewsRollCollectionCell *rollCell;


@property (nonatomic, strong) NSMutableArray<ClassifyModel *> *classifyList;
@property (nonatomic, strong) NSMutableArray<CourseModel *> *courseList;
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) NSArray<News *> *newsList;


@end

@implementation DYZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerView];
    [self loadData];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}



- (void)registerView {
    [self.collectionView registerNib:[UINib nibWithNibName:kClassifyCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kClassifyCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kVideoCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kVideoCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kHeadImageCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kHeadImageCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kDYZHomeBannerCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kDYZHomeBannerCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsRolCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kNewsRolCollectionCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kDYZVideoReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDYZVideoReusableView];
}


/// MARK: loadData
- (void)loadData {
    // 分类接口
    APIClassify *request = [APIClassify new];
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseClassify *responseObject, NSDictionary *options) {
        weakSelf.classifyList = responseObject.classifies;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
    
    // 推荐视频接口
    APIHomeCourseList *requestCourse = [APIHomeCourseList new];
    [requestCourse startPostWithSuccessBlock:^(ResponseHomeCourseList *responseObject, NSDictionary *options) {
        weakSelf.courseList = responseObject.coursesList;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
    // Banners
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"10";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
    // 资讯
    APINewsList *requestNews = [APINewsList new];
    requestNews.pageSize = 20;
    requestNews.currPage = 1;
    [requestNews startPostWithSuccessBlock:^(ResponseNewsList *responseObject, NSDictionary *options) {
        weakSelf.newsList = responseObject.content;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


/// MARK: collection'delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return enumVideoRecommendSection + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case enumHeaderImageSection:
        case enumNewsRollSection: {
            return 1;
        } break;
        case enumBannerSection: {
            return 1;
        } break;
        case enumClassifySection:{
            return self.classifyList.count > 10 ? 10 : self.classifyList.count;
        } break;
        case enumVideoRecommendSection:{
            return self.courseList.count;
        } break;
        default:
            break;
    }
    return 0;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case enumHeaderImageSection:{
            DYZHeadImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHeadImageCollectionCell forIndexPath:indexPath];
            cell.bannerList = self.bannerList;
            return cell;
        } break;
        case enumNewsRollSection: {
            if (self.rollCell) {
                if (!self.rollCell.newsList) {
                    self.rollCell.newsList = self.newsList;
                }
                return self.rollCell;
            }
            DYZNewsRollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsRolCollectionCell forIndexPath:indexPath];
            cell.newsList = self.newsList;
            self.rollCell = cell;
            return cell;
        } break;
        case enumBannerSection: {
            DYZHomeBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDYZHomeBannerCell forIndexPath:indexPath];
            return cell;
        } break;
        case enumClassifySection:{
            DYZClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassifyCollectionCell forIndexPath:indexPath];
            cell.model = self.classifyList[indexPath.row];
            return cell;
        } break;
        case enumVideoRecommendSection:{
            DYZVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVideoCollectionCell forIndexPath:indexPath];
            cell.model = self.courseList[indexPath.row];
            return cell;
        } break;
        default:
            break;
    }
    return [UICollectionViewCell new];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case enumHeaderImageSection: {
            return CGSizeMake(SCREEN_WIDTH, IS_IPAD?200:150);
        } break;
        case enumNewsRollSection: {
            return CGSizeMake(SCREEN_WIDTH, 40);
        } break;
        case enumBannerSection: {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*(114.0/750.0));
        } break;
        case enumClassifySection:{
            return CGSizeMake(60, 75);
        } break;
        case enumVideoRecommendSection:{
            CGFloat width = (SCREEN_WIDTH-20-20-1)/3.0;
            return CGSizeMake(width, width);
        } break;
        default:
            break;
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat spacingLeft = 10;
    CGFloat spacingRight = 10;
    switch (section) {
        case enumHeaderImageSection:
        case enumNewsRollSection: {
            return UIEdgeInsetsMake(0, spacingLeft, 0, spacingRight);
        } break;
        case enumClassifySection:{
            return UIEdgeInsetsMake(20, spacingLeft, 10, spacingRight);
        } break;
        case enumVideoRecommendSection:{
            return UIEdgeInsetsMake(0, spacingLeft, 0, spacingRight);
        } break;
        default:
            break;
    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == enumVideoRecommendSection) {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kDYZVideoReusableView forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case enumHeaderImageSection:
        case enumNewsRollSection: {
            [self openWebPageWithUrlString:_newsList[_rollCell.curIndex].url];
        } break;
        case enumBannerSection: {
            DYZClassCourseController *controller = [DYZClassCourseController new];
            controller.classID = @"100";
            [self.navigationController pushViewController:controller animated:YES];
        } break;
        case enumClassifySection:{
            ClassifyModel *classify = self.classifyList[indexPath.item];

            if ([classify.classID isEqualToString:@"-1"]) {
                UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                tab.selectedIndex = 1;
            } else {
                DYZClassCourseController *vc = [DYZClassCourseController new];
                vc.classify = classify;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } break;
        case enumVideoRecommendSection:{
            [self openWebPageWithUrlString:self.courseList[indexPath.row].url];
        } break;
        default:
            break;
    }
}

@end
