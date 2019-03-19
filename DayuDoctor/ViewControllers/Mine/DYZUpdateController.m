//
//  DYZUpdateController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZUpdateController.h"
#import "APIVersion.h"
#import "DYZVersionContentCell.h"


@interface DYZUpdateController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet UILabel *lblSize;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;


@end



@implementation DYZUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:kDYZVersionContentCell bundle:nil] forCellReuseIdentifier:kDYZVersionContentCell];
    
    [self createBaseView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)createBaseView {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 20;
    self.btnCancel.layer.masksToBounds = YES;
    self.btnCancel.layer.cornerRadius = 22;
    self.btnCancel.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
    self.btnCancel.layer.borderWidth = 1;
    self.btnOk.layer.masksToBounds = YES;
    self.btnOk.layer.cornerRadius = 22;
    self.btnOk.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
    self.btnOk.layer.borderWidth = 1;
}

- (void)refreshData {
    _lblName.text = _versionInfo.name;
    _lblVersion.text = _versionInfo.version;
    _lblSize.text = _versionInfo.size;
}



- (IBAction)didPressedCancel:(id)sender {
    [self dismiss];
}

- (IBAction)didPressedSure:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_versionInfo.url] options:@{} completionHandler:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    } else {
        __weak typeof(self) weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:kDYZVersionContentCell cacheByIndexPath:indexPath configuration:^(DYZVersionContentCell *cell) {
            cell.strContent = weakSelf.versionInfo.detail;
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.cellHeaderView;
    } else {
        DYZVersionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZVersionContentCell forIndexPath:indexPath];
        cell.strContent = _versionInfo.detail;
        return cell;
    }
}


- (void)setVersionInfo:(VersionInfo *)versionInfo {
    _versionInfo = versionInfo;
    [self.tableView reloadData];
}
@end
