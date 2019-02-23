//
//  DYZMeetDetailController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMeetDetailController.h"
#import "APIOrdersDetail.h"
#import "DYZMeetDetailCell.h"



@interface DYZMeetDetailController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ResponseOrdersDetail *responseOrdersDetail;
@property (nonatomic, strong) NSMutableArray *contentList;

@end

@implementation DYZMeetDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZMeetDetailCell bundle:nil] forCellReuseIdentifier:kDYZMeetDetailCell];
    [self loadData];
}



- (void)loadData {
    APIOrdersDetail *request = [APIOrdersDetail new];
    request.rid = _rid;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseOrdersDetail = responseObject;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}





/// MARK: tableView'delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZMeetDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMeetDetailCell forIndexPath:indexPath];
    cell.model = self.contentList[indexPath.row];
    return cell;
}



/// MARK: setter/getter
- (NSMutableArray *)contentList {
    if (!_contentList) {
        _contentList = [NSMutableArray array];
    }
    return _contentList;
}


- (void)setResponseOrdersDetail:(ResponseOrdersDetail *)responseOrdersDetail {
    _responseOrdersDetail = responseOrdersDetail;
    OrdersDetail *detail = _responseOrdersDetail.detail;
    [self.contentList removeAllObjects];
    [self.contentList addObject:[PUserInfo createModel:@"我的专家：" value:detail.doctorName isDoctor:YES]];
    [self.contentList addObject:[PUserInfo createModel:@"姓名：" value:detail.userName]];
    [self.contentList addObject:[PUserInfo createModel:@"性别：" value:detail.sex]];
    [self.contentList addObject:[PUserInfo createModel:@"年龄：" value:detail.age]];
    [self.contentList addObject:[PUserInfo createModel:@"联系方式：" value:detail.telephone]];
    [self.contentList addObject:[PUserInfo createModel:@"时间：" value:detail.orderDate]];

}

@end
