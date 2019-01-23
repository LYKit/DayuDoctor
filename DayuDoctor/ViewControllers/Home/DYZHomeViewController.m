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
#import "APIClassify.h"

typedef enum : NSUInteger {
    enumHeaderImageSection,
    enumNewsRollSection,
    enumClassifySection,
    enumVideoRecommendSection
} enumSectionType;

@interface DYZHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *classifyList;


@end

@implementation DYZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerNib:[UINib nibWithNibName:kClassifyCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kClassifyCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kVideoCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kVideoCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kHeadImageCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kHeadImageCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsRolCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kNewsRolCollectionCell];

    [self loadData];
}

/// MARK: loadData
- (void)loadData {
    APIClassify *request = [APIClassify new];
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseClassify *responseObject, NSDictionary *options) {
        weakSelf.classifyList = responseObject.classifies;
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
            return 10;
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
            return cell;
        } break;
        case enumNewsRollSection: {
            DYZNewsRollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsRolCollectionCell forIndexPath:indexPath];
            return cell;
        } break;
        case enumClassifySection:{
            DYZClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassifyCollectionCell forIndexPath:indexPath];
            cell.model = self.classifyList[indexPath.row];
            return cell;
        } break;
        case enumVideoRecommendSection:{
            DYZVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVideoCollectionCell forIndexPath:indexPath];
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
            return CGSizeMake(SCREEN_WIDTH, 50);
        } break;
        case enumClassifySection:{
            return CGSizeMake(70, 75);
        } break;
        case enumVideoRecommendSection:{
            return CGSizeMake(100, 50);
        } break;
        default:
            break;
    }
    return CGSizeZero;
}

@end
