//
//  DYZCoursesTableController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCoursesTableController.h"
#import "DYZCoursesTableCell.h"
#import "APICoursesList.h"

@interface DYZCoursesTableController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) APICoursesList *request;
@property (nonatomic, strong) ResponseCoursesList *response;
@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation DYZCoursesTableController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的课程";
    [self setupTableView];

    _request = [APICoursesList new];
    _request.currPage = 1;
    _request.pageSize = 20;
    
    [self myCourseRequest];
    _request.noResultView = self.tableView;
    _request.dataSource = self.models;
}

- (void)myCourseRequest {
    
    __weak typeof(self) _self = self;
    [_request startPostWithSuccessBlock:^(ResponseCoursesList *response, NSDictionary *options) {
        _self.response = response;
        
        if (_self.request.currPage == 1) {
            [self.models removeAllObjects];
        }
        [self.models addObjectsFromArray:_response.content];
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
    [_tableView registerClass:[DYZCoursesTableCell class] forCellReuseIdentifier:@"cell"];
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
        [_self myCourseRequest];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self myCourseRequest];
    }];
    
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZCoursesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.models.count) {
        Course *course = self.models[indexPath.row];
        [cell setCourse:course];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Course *model = self.models[indexPath.row];
    [self openWebPageWithUrlString:model.url];
}

@end
