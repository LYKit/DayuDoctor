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
@property (nonatomic, strong) ResponseReservations *responseReservations;


@end

@implementation DYZVMeetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.tableView registerNib:[UINib nibWithNibName:kDYZMeetingCell bundle:nil] forCellReuseIdentifier:kDYZMeetingCell];
    
    [self loadData];
}


- (void)loadData {
    APIReservations *request = [APIReservations new];
    request.page = 1;
    request.pageSize = 20;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseReservations = responseObject;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _responseReservations.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMeetingCell forIndexPath:indexPath];
    Reservations *model = _responseReservations.list[indexPath.row];
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
    detail.rid = _responseReservations.list[indexPath.row].rid;
    [self.navigationController pushViewController:detail animated:YES];
}


// 取消预约
- (void)didPressedCancel:(NSString *)rid {
    APIOrderCancel *request = [APIOrderCancel new];
    request.rid = rid;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        if (responseObject.resultcode.integerValue == 0) {
            [weakSelf loadData];
            [weakSelf.view makeToast:@"取消成功"];
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}



@end
