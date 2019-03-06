//
//  DYZClassifyController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZClassifyController.h"
#import "DYZClassifyCollectionCell.h"
#import "APIClassifyAll.h"
#import "DYZClassCourseController.h"

@interface DYZClassifyController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *classifyList;

@end

@implementation DYZClassifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:kClassifyCollectionCell bundle:nil] forCellWithReuseIdentifier:kClassifyCollectionCell];
    [self loadData];
}


- (void)loadData {
    // 分类接口
    APIClassifyAll *request = [APIClassifyAll new];
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseClassify *responseObject, NSDictionary *options) {
        weakSelf.classifyList = responseObject.classifies;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classifyList.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassifyCollectionCell forIndexPath:indexPath];
    cell.model = self.classifyList[indexPath.row];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 75);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DYZClassCourseController *vc = [DYZClassCourseController new];
    ClassifyModel *classify = self.classifyList[indexPath.item];
    vc.classify = classify;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
