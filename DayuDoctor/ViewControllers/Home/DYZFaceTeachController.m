//
//  DYZFaceTeachController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZFaceTeachController.h"
#import "DYZFaceTeachCell.h"
#import "APIFaceTeach.h"
#import "APIHomeBanner.h"
#import "DYZHeadImageCell.h"

@interface DYZFaceTeachController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APIFaceTeach *requestFace;
@property (nonatomic, strong) ResponseFaceTeach *responseFace;
@property (nonatomic, strong) NSMutableArray *bannerList;


@end

@implementation DYZFaceTeachController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:kDYZFaceTeachCell bundle:nil] forCellReuseIdentifier:kDYZFaceTeachCell];
    [self.tableView registerNib:[UINib nibWithNibName:kDYZHeadImageCell bundle:nil] forCellReuseIdentifier:kDYZHeadImageCell];

    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }

        _self.requestFace.currPage = 1;
        [_self loadDefaultData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestFace.currPage += 1;
        [_self loadDefaultData];
    }];
    
    self.requestFace.currPage = 1;
    self.requestFace.pageSize = 20;
    self.requestFace.dataSource = self.models;
    self.requestFace.noResultView = self.tableView;

    [self loadDefaultData];
}

- (void)loadDefaultData  {
    __weak typeof(self) weakSelf = self;
    [self.requestFace startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseFace = responseObject;
        if (weakSelf.requestFace.currPage == 1) {
            [self.models removeAllObjects];
        }
        
        [self.models addObjectsFromArray:_responseFace.content];
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
    }];
    
    
    // Banners
    APIHomeBanner *requestBanner = [APIHomeBanner new];
    requestBanner.type = @"12";
    [requestBanner startPostWithSuccessBlock:^(ResponseHomeBanner *responseObject, NSDictionary *options) {
        weakSelf.bannerList = responseObject.banners;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];

}

- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DYZHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZHeadImageCell forIndexPath:indexPath];
        cell.bannerList = self.bannerList;
        return cell;
    }
    DYZFaceTeachCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZFaceTeachCell forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    FaceTeachModel *model = self.models[indexPath.row];
    [self openWebPageWithUrlString:model.url];
}


- (APIFaceTeach *)requestFace {
    if (!_requestFace) {
        _requestFace = [APIFaceTeach new];
    }
    return _requestFace;
}

@end
