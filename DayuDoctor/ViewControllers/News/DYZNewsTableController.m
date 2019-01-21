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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"资讯列表";
    [self setupTableView];
    
    
    _request = [APINewsList new];
    [_request startPostWithSuccessBlock:^(ResponseNewsList *response, NSDictionary *options) {
        _response = response;
        
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
    
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[DYZNewsTableCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_response.data.content.count) {
        return _response.data.content.count;
    } else {
        return 10;
    }
}
@end
