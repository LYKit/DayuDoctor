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
#import "DYZBaseNavigationController.h"
#import "DYZApplyController.h"
#import "DYZClassCourseDetailController.h"

@interface DYZClassCourseController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APICourseClassify *request;
@property (nonatomic, strong) ResponseCourseClassify *response;

@end

@implementation DYZClassCourseController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    _request = [APICourseClassify new];
    _request.currPage = 1;
    _request.pageSize = 20;
    _request.classifyId = _classify.classID ? _classify.classID :_classID;
    _request.dataSource = self.models;
    _request.noResultView = self.tableView;
    [self requestClassifyClass];
    
    self.navigationItem.title = _classID ? @"报名" : @"课程列表";
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = ({
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
            left.tintColor = [UIColor colorWithHexString:@"666666"];
            left;
        });
    }
}

- (void)backAction { // 定的什么鸡儿奇葩交互
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    if ([((DYZBaseNavigationController *)tab.selectedViewController).viewControllers[0] isKindOfClass:[DYZApplyController class]]) {
        [tab setSelectedIndex:0];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestClassifyClass {
    __weak typeof(self) _self = self;
    
    [_request startPostWithSuccessBlock:^(ResponseCourseClassify *response, NSDictionary *options) {
        _self.response = response;
        if (_self.request.currPage == 1) {
            [_self.models removeAllObjects];
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
    [_tableView registerClass:[DYZClassCourseCell class] forCellReuseIdentifier:@"cell"];
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
        [_self requestClassifyClass];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self requestClassifyClass];
    }];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZClassCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.models.count) {
        ClassifyCourse *cousre = self.models[indexPath.row];
        [cell setClassifyCourse:cousre];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassifyCourse *model = self.models[indexPath.row];
    NSLog(@"点击cell");
    if (   [[DYZMemberManager getMemberInfo].mobile isEqualToString:@"18610592122"]
        || ![DYZMemberManager isLogin]) {
        DYZClassCourseDetailController *vc = [DYZClassCourseDetailController new];
        vc.course = model;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self openWebPageWithUrlString:model.url];
    }
}


@end
