//
//  DYZOrderController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZOrderController.h"
#import "DYZOrderInfoCell.h"
#import "APIOrderList.h"
#import "APICancelOrder.h"



@interface DYZOrderController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) APIOrderList *requestOrderList;
@property (nonatomic, strong) ResponseOrderList *responeOrderList;
@property (nonatomic, strong) NSMutableArray<OrderModel *> *dataList;


@end

@implementation DYZOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZOrderInfoCell bundle:nil] forCellReuseIdentifier:kDYZOrderInfoCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self loadData];
    
    _requestOrderList.dataSource = self.dataList;
    _requestOrderList.noResultView = _tableView;
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }
        _self.requestOrderList.currPage = 1;
        [_self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestOrderList.currPage += 1;
        [_self loadData];
    }];
}


- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.requestOrderList startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responeOrderList = responseObject;
        if (weakSelf.requestOrderList.currPage == 1) {
            [weakSelf.dataList removeAllObjects];
        }
        [weakSelf.dataList addObjectsFromArray:weakSelf.responeOrderList.list];
        [weakSelf.tableView reloadData];

    } failBlock:^(LYNetworkError *error, NSDictionary *options) {

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZOrderInfoCell forIndexPath:indexPath];
    OrderModel *model = self.dataList[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    cell.cancelBlock = ^{
        [weakSelf didPressedCancel:model];
    };
    cell.payBlock = ^{
        [weakSelf didPressedPay:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openWebPageWithUrlString:self.dataList[indexPath.row].url];
}


- (APIOrderList *)requestOrderList {
    if (!_requestOrderList) {
        _requestOrderList = [APIOrderList new];
        _requestOrderList.pageSize = 20;
        _requestOrderList.currPage = 1;
    }
    return _requestOrderList;
}

- (NSMutableArray<OrderModel *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (void)didPressedCancel:(OrderModel *)model {
    __weak typeof(self) weakSelf = self;
    [LYAlertView showAerltViewWithTitle:@"提示" message:@"是否要取消订单" cancelButtonTtitle:@"取消" ensuerButtonTitle:@"确定" onSureUsingBlock:^{
        [weakSelf requestCancel:model.transId];
    } onCancelUsingBlock:^{
        
    }];

    

}

- (void)requestCancel:(NSString *)transId {
    __weak typeof(self) weakSelf = self;

    APICancelOrder *request = [APICancelOrder new];
    request.transId = transId;
    [request startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        [weakSelf.view makeToast:@"取消成功"];
        weakSelf.requestOrderList.currPage = 1;
        [weakSelf loadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)didPressedPay:(OrderModel *)model {
    [self openWebPageWithUrlString:model.payUrl];
}
@end
