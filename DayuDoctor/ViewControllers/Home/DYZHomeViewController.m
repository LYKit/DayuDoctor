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

typedef enum : NSUInteger {
    enumHeaderImageSection,
    enumNewsRollSection,
    enumClassifySection,
    enumVideoRecommendSection
} enumSectionType;

@interface DYZHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionReusableView *headerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *classifyList;
@property (nonatomic, strong) NSMutableArray *courseList;
@property (nonatomic, strong) NSMutableArray *bannerList;
@property (nonatomic, strong) NSArray *newsList;


@end

@implementation DYZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    [self registerView];
    [self createBaseView];
    [self loadData];
}

- (void)createBaseView {
    
}

- (void)registerView {
    [self.collectionView registerNib:[UINib nibWithNibName:kClassifyCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kClassifyCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kVideoCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kVideoCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kHeadImageCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kHeadImageCollectionCell];
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
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
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
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
    // 资讯
    APINewsList *requestNews = [APINewsList new];
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
            DYZNewsRollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsRolCollectionCell forIndexPath:indexPath];
            cell.newsList = self.newsList;
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
            return CGSizeMake(SCREEN_WIDTH, 150);
        } break;
        case enumNewsRollSection: {
            return CGSizeMake(SCREEN_WIDTH, 40);
        } break;
        case enumClassifySection:{
            return CGSizeMake(70, 75);
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

        } break;
        case enumClassifySection:{
            DYZClassCourseController *vc = [DYZClassCourseController new];
            ClassifyModel *classify = self.classifyList[indexPath.item];
            vc.classify = classify;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            vc.hidesBottomBarWhenPushed = NO;
        } break;
        case enumVideoRecommendSection:{

        } break;
        default:
            break;
    }
}

@end
