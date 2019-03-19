//
//  DYZVMeetController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZVMeetController.h"
#import "APIReservations.h"
#import "DYZMeetingCell.h"
#import "APIOrderCancel.h"
#import "DYZMeetDetailController.h"


@interface DYZVMeetController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) ResponseReservations *responseReservations;
@property (nonatomic, strong) APIReservations *request;
@end

@implementation DYZVMeetController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    self.tableView.rowHeight = 100;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.tableView registerNib:[UINib nibWithNibName:kDYZMeetingCell bundle:nil] forCellReuseIdentifier:kDYZMeetingCell];
    
    
    _request = [APIReservations new];
    _request.currPage = 1;
    _request.pageSize = 20;
    _request.dataSource = self.models;
    _request.noResultView = self.tableView;

    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }
        _self.request.currPage = 1;
        [_self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self loadData];
    }];

    [self loadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [_request startPostWithSuccessBlock:^(ResponseReservations *responseObject, NSDictionary *options) {
        
        if (_request.currPage == 1) {
            [self.models removeAllObjects];
        }
        
        [self.models addObjectsFromArray:responseObject.list];
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {

    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMeetingCell forIndexPath:indexPath];
    Reservations *model = self.models[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    cell.cancelBlock = ^{
        [LYAlertView showAerltViewWithTitle:@"提示" message:@"是否要取消预约" cancelButtonTtitle:@"返回" ensuerButtonTitle:@"确定" onSureUsingBlock:^{
            [weakSelf didPressedCancel:model.rid];
        } onCancelUsingBlock:nil];
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DYZMeetDetailController *detail = [DYZMeetDetailController new];
    Reservations *model = self.models[indexPath.row];
    detail.rid = model.rid;
    [self.navigationController pushViewController:detail animated:YES];
}


// 取消预约
- (void)didPressedCancel:(NSString *)rid {
    APIOrderCancel *request = [APIOrderCancel new];
    request.rid = rid;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        [weakSelf loadData];
        [weakSelf.view makeToast:@"取消成功"];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


@end
