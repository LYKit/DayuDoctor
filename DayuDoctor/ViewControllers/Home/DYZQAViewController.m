//
//  DYZQAViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZQAViewController.h"
#import "APIFAQS.h"
#import "DYZQACell.h"
#import "APIHomeBanner.h"
#import "DYZHeadImageCell.h"

@interface DYZQAViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APIFAQS *requestQA;
@property (nonatomic, strong) NSMutableArray *bannerList;

@end

@implementation DYZQAViewController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZQACell bundle:nil] forCellReuseIdentifier:kDYZQACell];
    [self.tableView registerNib:[UINib nibWithNibName:kDYZHeadImageCell bundle:nil] forCellReuseIdentifier:kDYZHeadImageCell];

    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }
        _self.requestQA.currPage = 1;
        [_self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestQA.currPage += 1;
        [_self loadData];
    }];

    
    self.requestQA.currPage = 1;
    self.requestQA.pageSize = 20;
    self.requestQA.dataSource = self.models;
    self.requestQA.noResultView = self.tableView;

    [self loadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.requestQA startPostWithSuccessBlock:^(ResponseFAQS *responseObject, NSDictionary *options) {
        if (weakSelf.requestQA.currPage == 1) {
            [self.models removeAllObjects];
        }
        [self.models addObjectsFromArray:responseObject.list];
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
    }];
    
    // Banners
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"3";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


/// MARK: tableview'delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    }
    __weak typeof(self) weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:kDYZQACell cacheByIndexPath:indexPath configuration:^(DYZQACell *cell) {
        cell.model = weakSelf.models[indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DYZHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZHeadImageCell forIndexPath:indexPath];
        cell.bannerList = self.bannerList;
        return cell;
    }
    DYZQACell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZQACell forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (APIFAQS *)requestQA {
    if (!_requestQA) {
        _requestQA = [APIFAQS new];
    }
    return _requestQA;
}

@end
