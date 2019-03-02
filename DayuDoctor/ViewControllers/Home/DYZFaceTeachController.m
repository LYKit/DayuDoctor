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
@property (nonatomic, strong) APIFaceTeach *requestFace;
@property (nonatomic, strong) ResponseFaceTeach *responseFace;


@end

@implementation DYZFaceTeachController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.tableView registerNib:[UINib nibWithNibName:kDYZFaceTeachCell bundle:nil] forCellReuseIdentifier:kDYZFaceTeachCell];
    
    [self loadDefaultData];
}

- (void)loadDefaultData  {
    self.requestFace.currPage = 1;
    self.requestFace.pageSize = 20;
    __weak typeof(self) weakSelf = self;
    [self.requestFace startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseFace = responseObject;
        [weakSelf.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _responseFace.content.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZFaceTeachCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZFaceTeachCell forIndexPath:indexPath];
    cell.model = _responseFace.content[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self openWebPageWithUrlString:_responseFace.content[indexPath.row].url];
}


- (APIFaceTeach *)requestFace {
    if (!_requestFace) {
        _requestFace = [APIFaceTeach new];
    }
    return _requestFace;
}

@end
