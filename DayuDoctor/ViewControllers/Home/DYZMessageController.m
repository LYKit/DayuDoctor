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
@property (nonatomic, strong) APIMessage *requestMessage;
@property (nonatomic, strong) NSArray<Message *> *arrayMessage;

@end

@implementation DYZMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZMessageCell bundle:nil] forCellReuseIdentifier:kDYZMessageCell];
    
    [self loadData];
}


- (void)loadData {
    self.requestMessage.pageSize = 10;
    self.requestMessage.currPage = 1;
    __weak typeof(self) weakSelf = self;
    [self.requestMessage startPostWithSuccessBlock:^(ResponseMessage *responseObject, NSDictionary *options) {
        weakSelf.arrayMessage = responseObject.list;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayMessage.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMessageCell forIndexPath:indexPath];
    cell.model = _arrayMessage[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openWebPageWithUrlString:_arrayMessage[indexPath.row].url];
}



- (APIMessage *)requestMessage {
    if (!_requestMessage) {
        _requestMessage = [APIMessage new];
    }
    return _requestMessage;
}

@end
