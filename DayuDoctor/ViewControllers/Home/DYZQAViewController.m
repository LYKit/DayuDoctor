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
@property (nonatomic, strong) APIFAQS *requestQA;
@property (nonatomic, strong) NSArray *listQA;

@end

@implementation DYZQAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kDYZQACell bundle:nil] forCellReuseIdentifier:kDYZQACell];
    
    [self loadData];
}

- (void)loadData {
    self.requestQA.currPage = 0;
    self.requestQA.pageSize = 10;
    __weak typeof(self) weakSelf = self;
    [self.requestQA startPostWithSuccessBlock:^(ResponseFAQS *responseObject, NSDictionary *options) {
        weakSelf.listQA = responseObject.list;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


/// MARK: tableview'delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listQA.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:kDYZQACell cacheByIndexPath:indexPath configuration:^(DYZQACell *cell) {
        cell.model = weakSelf.listQA[indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZQACell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZQACell forIndexPath:indexPath];
    cell.model = _listQA[indexPath.row];
    return cell;
}



- (APIFAQS *)requestQA {
    if (!_requestQA) {
        _requestQA = [APIFAQS new];
    }
    return _requestQA;
}

#warning  需删除
- (NSArray *)listQA {
    if (!_listQA) {
        NSMutableArray *array = [NSMutableArray array];
        {
            FAQSModel *model = [FAQSModel new];
            model.question = @"范德萨范德萨发的萨芬大";
            model.answer = @"范德萨范德萨发的萨芬大fdsff发的萨芬大范德萨阿范德萨发的方方达发送 方方达";
            [array addObject:model];
        }
        {
            FAQSModel *model = [FAQSModel new];
            model.question = @"范德萨范德萨发的萨芬大发生范德萨发范德萨范德萨范德萨范德萨a";
            model.answer = @"范德萨范德萨发的萨芬大";
            [array addObject:model];
        }
        {
            FAQSModel *model = [FAQSModel new];
            model.question = @"范德萨范德萨发的萨芬大";
            model.answer = @"范德萨范德萨发的萨芬大";
            [array addObject:model];
        }
        _listQA = array;
    }
    return _listQA;
}
@end
