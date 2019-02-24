//
//  DYZCachedListController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCachedListController.h"
#include <sys/param.h>
#include <sys/mount.h>
#import "DYZCachingCell.h"



@interface DYZCachedListController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *memoryLabel;
@property (nonatomic, strong) UIButton *pasueButton;
@property (nonatomic, strong) UIButton *editButton;
@end

@implementation DYZCachedListController

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
        make.top.equalTo(_pasueButton.mas_bottom).mas_offset(5);
        make.left.right.bottom.equalTo(self.view);
    }];
}


- (void)setupMemoryLabel {
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    label.text = [self freeDiskSpaceInBytes];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(17);
    }];
    _memoryLabel = label;
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton.layer.cornerRadius = 5;
    _editButton.layer.masksToBounds = YES;
    _editButton.backgroundColor = [UIColor blackColor];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_memoryLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(90);
    }];
    [_editButton addTarget:self
                    action:@selector(editAction)
          forControlEvents:UIControlEventTouchUpInside];
    

    _pasueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pasueButton.layer.cornerRadius = 5;
    _pasueButton.layer.masksToBounds = YES;
    _pasueButton.backgroundColor = [UIColor blackColor];
    _pasueButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pasueButton setTitle:@"全部暂停" forState:UIControlStateNormal];
    [_pasueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_pasueButton];
    [_pasueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_memoryLabel.mas_bottom).mas_offset(10);
        make.right.equalTo(_editButton.mas_left).mas_offset(-10);
        make.width.mas_equalTo(100);
    }];
    [_pasueButton addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editAction {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)pauseAction:(UIButton *)button {
    
}

- (NSString *)freeDiskSpaceInBytes {
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace / 1024 / 1024 ];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZCachingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
