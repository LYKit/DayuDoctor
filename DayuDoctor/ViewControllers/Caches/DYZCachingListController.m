//
//  DYZCachingListController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCachingListController.h"
#import "DYZCachingCell.h"

@interface DYZCachingListController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation DYZCachingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMemoryLabel];
    [self setupTableView];    
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[DYZCachingCell class] forCellReuseIdentifier:@"cell"];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editButton.mas_bottom).mas_offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
}


- (void)setupMemoryLabel {
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton.layer.cornerRadius = 5;
    _editButton.layer.masksToBounds = YES;
    _editButton.backgroundColor = [UIColor blackColor];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(90);
    }];
    [_editButton addTarget:self
                    action:@selector(editAction)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)editAction {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)pauseAction:(UIButton *)button {
    
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZCachingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    return self.models.count;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

@end
