//
//  DYZSearchListController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZSearchListController.h"
#import "APISearchList.h"
#import "DYZSearchListCell.h"

@interface DYZSearchListController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *seachList;


@end

@implementation DYZSearchListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZSearchListCell bundle:nil] forCellReuseIdentifier:kDYZSearchListCell];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadData {
    APISearchList *request = [APISearchList new];
    request.pageSize = 10;
    request.currPage = 1;
    request.keywords = _keyword;
    __weak typeof(self) weakSelf = self;
    [request startPostWithSuccessBlock:^(ResponseSearchList *responseObject, NSDictionary *options) {
        weakSelf.seachList = responseObject.content;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seachList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZSearchListCell forIndexPath:indexPath];
    cell.model = self.seachList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



/// MARK: setter/getter
- (void)setKeyword:(NSString *)keyword {
    _keyword = keyword;
    self.title = _keyword;
}

@end
