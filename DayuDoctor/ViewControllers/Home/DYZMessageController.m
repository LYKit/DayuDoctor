//
//  DYZMessageController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMessageController.h"
#import "APIMessage.h"
#import "DYZMessageCell.h"


@interface DYZMessageController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APIMessage *requestMessage;
@property (nonatomic, strong) NSArray<Message *> *arrayMessage;

@end

@implementation DYZMessageController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.tableView.rowHeight = 80;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZMessageCell bundle:nil] forCellReuseIdentifier:kDYZMessageCell];
    
    self.requestMessage.currPage = 1;
    self.requestMessage.pageSize = 20;
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _self.requestMessage.currPage = 1;
        [_self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestMessage.currPage += 1;
        [_self loadData];
    }];


    [self loadData];
}


- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.requestMessage startPostWithSuccessBlock:^(ResponseMessage *responseObject, NSDictionary *options) {
        
        if (self.requestMessage.currPage == 1) {
            [weakSelf.models removeAllObjects];
        }
        [weakSelf.models addObjectsFromArray:responseObject.list];
        [weakSelf.tableView reloadData];
        [self endRefreshing];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        [self endRefreshing];
    }];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMessageCell forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Message *msg = self.models[indexPath.row];
    [self openWebPageWithUrlString:msg.url];
}



- (APIMessage *)requestMessage {
    if (!_requestMessage) {
        _requestMessage = [APIMessage new];
    }
    return _requestMessage;
}


- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
