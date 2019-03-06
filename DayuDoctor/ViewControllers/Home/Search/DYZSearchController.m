//
//  DYZSearchController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZSearchController.h"
#import "APISearchRecord.h"
#import "DYZSearchCollectionCell.h"
#import "UIView+CALayerRelation.h"
#import "DYZSearchListController.h"
#import "UIImage+YYAdd.h"
#import "DYZCacheParentController.h"
#import "APISearchClear.h"

@interface DYZSearchController () <UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (nonatomic, strong) NSMutableArray *recordList;

@end

@implementation DYZSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBaseView];
    [self loadData];
    
    self.searchBar.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kDYZSearchCollectionCell bundle:nil] forCellWithReuseIdentifier:kDYZSearchCollectionCell];
    
    UIImage *image = [UIImage imageNamed:@"back"];
    [self.btnBack setImage:image forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.searchBar becomeFirstResponder];
    });
    
}


- (void)loadData {
    [self.recordList removeAllObjects];

    APISearchRecord *request = [APISearchRecord new];
    request.currPage = 1;
    request.pageSize = 10;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseSearchRecord *responseObject, NSDictionary *options) {
        weakSelf.recordList = responseObject.record;
        [weakSelf.collectionView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (IBAction)didPressedDownload:(id)sender {
    DYZCacheParentController *vc = [DYZCacheParentController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didPressedClear:(id)sender {
    __weak typeof(self) weakSelf = self;
    [[APISearchClear new] startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        [weakSelf loadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (IBAction)didPressedBack:(id)sender {
    self.view.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
}


- (void)createBaseView {
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    for (UIView *view in self.searchBar.subviews) {
        for (UIView *subViews in view.subviews) {
            if ([subViews isKindOfClass:[UITextField class]]) {
                [subViews setRadius:15.0];
                subViews.backgroundColor = [UIColor whiteColor];//输入框背景色
                if (@available(iOS 11.0, *)) {
                    subViews.frame = CGRectMake(0, 7, self.searchBar.frame.size.width, 40);
                    UITextField *textField = (UITextField *)subViews;
                    textField.font = [UIFont systemFontOfSize:14.0f];
                    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
                }
                break;
            }
        }
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBarClicked:_searchBar.text];
}

- (void)searchBarClicked:(NSString *)keyword {
    DYZSearchListController *searchList = [DYZSearchListController new];
    searchList.keyword = keyword;
    [self.navigationController pushViewController:searchList animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recordList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [DYZSearchCollectionCell cellSize:_recordList[indexPath.row]];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDYZSearchCollectionCell forIndexPath:indexPath];
    cell.strTitle = _recordList[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self searchBarClicked:_recordList[indexPath.row]];
}
@end


