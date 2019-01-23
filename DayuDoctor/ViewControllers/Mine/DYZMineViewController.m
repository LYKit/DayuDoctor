//
//  DYZMineViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMineViewController.h"
#import "DYZMineCell.h"

@interface DYZMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) UIImageView *avatorImgView;
@property (nonatomic, strong) UIView *profileView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userDescLabel;

@end

@implementation DYZMineViewController

- (void)setuppProfileView {
    __weak typeof(self) _self = self;
    _profileView = [UIView new];
    _profileView.backgroundColor = [UIColor whiteColor];
    [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100));
    }];
    
    _avatorImgView = [UIImageView new];
    _avatorImgView.backgroundColor = [UIColor yellowColor];
    _avatorImgView.layer.cornerRadius = 30;
    _avatorImgView.layer.masksToBounds = YES;
    [_profileView addSubview:_avatorImgView];
    
    [_avatorImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [_profileView addSubview:_userNameLabel];
    _userNameLabel.text = @"sdafasf";
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_self.avatorImgView).mas_offset(5);
        make.left.equalTo(_self.avatorImgView.mas_right).mas_offset(10);
        make.right.mas_offset(-16);
    }];
    
    _userDescLabel = [UILabel new];
    _userDescLabel.font = [UIFont systemFontOfSize:13];
    _userDescLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [_profileView addSubview:_userDescLabel];
    _userDescLabel.text = @"sdafasf";
    [_userDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_self.avatorImgView).mas_offset(-5);
        make.left.equalTo(_self.avatorImgView.mas_right).mas_offset(10);
        make.right.mas_offset(-16);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 45;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[DYZMineCell class] forCellReuseIdentifier:@"cell"];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self setuppProfileView];
    _tableView.tableHeaderView = _profileView;
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *title = self.models[indexPath.row];
    cell.label.text = title;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
        [_models addObject:@"A"];
        [_models addObject:@"B"];
        [_models addObject:@"C"];
        [_models addObject:@"D"];
        [_models addObject:@"E"];
    }
    return _models;
}

@end
