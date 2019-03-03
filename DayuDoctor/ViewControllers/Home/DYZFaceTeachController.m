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

@interface DYZFaceTeachController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APIFaceTeach *requestFace;
@property (nonatomic, strong) ResponseFaceTeach *responseFace;


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
    [self.tableView registerNib:[UINib nibWithNibName:kDYZFaceTeachCell bundle:nil] forCellReuseIdentifier:kDYZFaceTeachCell];

    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _self.requestFace.currPage = 1;
        [_self loadDefaultData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestFace.currPage += 1;
        [_self loadDefaultData];
    }];
    
    self.requestFace.currPage = 1;
    self.requestFace.pageSize = 20;

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
        [self endRefreshing];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        [self endRefreshing];
    }];
}

- (void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZFaceTeachCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZFaceTeachCell forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
