//
//  DYZNewsTableController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZNewsTableController.h"
#import "DYZNewsTableCell.h"
#import "DYZHeadImageCell.h"
#import "APINewsList.h"

@interface DYZNewsTableController()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APINewsList *request;
@property (nonatomic, strong) ResponseNewsList *response;
@property (nonatomic, strong) NSMutableArray *bannerList;

@end

@implementation DYZNewsTableController
- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯列表";
    
    _request = [APINewsList new];
    _request.currPage = 1;
    _request.pageSize = 20;
    
    [self setupTableView];
    [self requestNews];
    
    _request.noResultView = _tableView;
    _request.dataSource = self.models;
    
    // Banners
    __weak typeof(self) weakSelf = self;
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"1";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)requestNews {
    __weak typeof(self) _self = self;
    
    [_request startPostWithSuccessBlock:^(ResponseNewsList *response, NSDictionary *options) {
        _self.response = response;
        if (_self.request.currPage == 1) {
            [self.models removeAllObjects];
        }
        
        [self.models addObjectsFromArray:response.content];
        [_self.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {

    }];
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[DYZNewsTableCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:kDYZHeadImageCell bundle:nil] forCellReuseIdentifier:kDYZHeadImageCell];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }
        _self.request.currPage = 1;
        [_self requestNews];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self requestNews];
    }];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DYZHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZHeadImageCell forIndexPath:indexPath];
        cell.bannerList = self.bannerList;
        return cell;
    }
    DYZNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.models.count) {
        News *news = self.models[indexPath.row];
        [cell setNews:news];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    News *news = self.models[indexPath.row];
    [self openWebPageWithUrlString:news.url];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
