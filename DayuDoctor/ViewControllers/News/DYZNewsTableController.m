//
//  DYZNewsTableController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZNewsTableController.h"
#import "DYZNewsTableCell.h"
#import "APINewsList.h"

@interface DYZNewsTableController()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APINewsList *request;
@property (nonatomic, strong) ResponseNewsList *response;
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
        [_self endRefreshing];
        
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        [_self endRefreshing];
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
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _self.request.currPage = 1;
        [_self requestNews];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self requestNews];
    }];
}

- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.models.count) {
        News *news = self.models[indexPath.row];
        [cell setNews:news];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = self.models[indexPath.row];
    [self openWebPageWithUrlString:news.url];
}
@end
