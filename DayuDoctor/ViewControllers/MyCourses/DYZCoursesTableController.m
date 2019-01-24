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

@end

@implementation DYZCoursesTableController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.title = @"啥答案撒所多";
    
    _request = [APICoursesList new];
    
    __weak typeof(self) _self = self;
    
    [_request startPostWithSuccessBlock:^(ResponseCoursesList *response, NSDictionary *options) {
        _self.response = response;
        [_self.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
    }];
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[DYZCoursesTableCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZCoursesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_response.content.count) {
        Course *course = _response.content[indexPath.row];
        cell.textLabel.text = course.title;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _response.content.count;
}
@end
