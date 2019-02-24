//
//  DYZClassCourseController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZClassCourseController.h"
#import "APICourseClassify.h"
#import "DYZClassCourseCell.h"

@interface DYZClassCourseController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) APICourseClassify *request;
@property (nonatomic, strong) ResponseCourseClassify *response;

@end

@implementation DYZClassCourseController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程列表";

    [self setupTableView];
    _request = [APICourseClassify new];
    _request.currPage = 1;
    _request.pageSize = 5;
    _request.classifyId = _classify.classID;
    [self requestClassifyClass];
}

- (void)requestClassifyClass {
    __weak typeof(self) _self = self;
    
    [_request startPostWithSuccessBlock:^(ResponseCourseClassify *response, NSDictionary *options) {
        _self.response = response;
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
    [_tableView registerClass:[DYZClassCourseCell class] forCellReuseIdentifier:@"cell"];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        _self.request.currPage = 1;
        [_self requestClassifyClass];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //        _self.request.currPage += 1;
        [_self requestClassifyClass];
    }];
}

- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZClassCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_response.content.count) {
        ClassifyCourse *cousre = _response.content[indexPath.row];
        [cell setClassifyCourse:cousre];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _response.content.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
