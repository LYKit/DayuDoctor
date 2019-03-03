//
//  DYZQAViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZQAViewController.h"
#import "APIFAQS.h"
#import "DYZQACell.h"


@interface DYZQAViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) APIFAQS *requestQA;
@end

@implementation DYZQAViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:kDYZQACell bundle:nil] forCellReuseIdentifier:kDYZQACell];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _self.requestQA.currPage = 1;
        [_self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.requestQA.currPage += 1;
        [_self loadData];
    }];

    
    self.requestQA.currPage = 1;
    self.requestQA.pageSize = 20;

    [self loadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.requestQA startPostWithSuccessBlock:^(ResponseFAQS *responseObject, NSDictionary *options) {
        if (weakSelf.requestQA.currPage == 1) {
            [self.models removeAllObjects];
        }
        [self.models addObjectsFromArray:responseObject.list];
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

/// MARK: tableview'delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:kDYZQACell cacheByIndexPath:indexPath configuration:^(DYZQACell *cell) {
        cell.model = weakSelf.models[indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZQACell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZQACell forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}


- (APIFAQS *)requestQA {
    if (!_requestQA) {
        _requestQA = [APIFAQS new];
    }
    return _requestQA;
}

#warning  需删除
//- (NSArray *)listQA {
//    if (!_listQA) {
//        NSMutableArray *array = [NSMutableArray array];
//        {
//            FAQSModel *model = [FAQSModel new];
//            model.question = @"范德萨范德萨发的萨芬大";
//            model.answer = @"范德萨范德萨发的萨芬大fdsff发的萨芬大范德萨阿范德萨发的方方达发送 方方达";
//            [array addObject:model];
//        }
//        {
//            FAQSModel *model = [FAQSModel new];
//            model.question = @"范德萨范德萨发的萨芬大发生范德萨发范德萨范德萨范德萨范德萨a";
//            model.answer = @"范德萨范德萨发的萨芬大";
//            [array addObject:model];
//        }
//        {
//            FAQSModel *model = [FAQSModel new];
//            model.question = @"范德萨范德萨发的萨芬大";
//            model.answer = @"范德萨范德萨发的萨芬大";
//            [array addObject:model];
//        }
//        _listQA = array;
//    }
//    return _listQA;
//}
@end
