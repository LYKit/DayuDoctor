//
//  DYZMyCollectionViewController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZMyCollectionViewController.h"
#import "APIMyCollectionList.h"
#import "DYZMyCollectionCell.h"
#import "DYZCacheListBottomView.h"
#import "APIDeleteCollection.h"
#import <Toast.h>


@interface DYZMyCollectionViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) APIMyCollectionList *request;
@property (nonatomic, strong) ResponseMyCollectionList *response;
@property (nonatomic, strong) DYZCacheListBottomView *bottomView;
@property (nonatomic, strong) APIDeleteCollection *deleteRequest;
@property (nonatomic, assign) BOOL isEditing;//标记按钮
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation DYZMyCollectionViewController

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";

    _request = [APIMyCollectionList new];
    _request.currPage = 1;
    _request.pageSize = 20;
    
    [self setupTableView];
    [self requestNews];
    [self setupBottomView];
    _request.noResultView = self.tableView;
    _request.dataSource = self.models;
    
    _isEditing = NO;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)editAction:(UIBarButtonItem *)sender {
    _isEditing = !_isEditing;
    if (_isEditing) {
        sender.title = @"取消编辑";
    } else {
        sender.title = @"编辑";
    }
    
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    BOOL isEditing = self.tableView.editing;
    if (isEditing) {
        _bottomView.hidden = NO;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).mas_offset(34);
        }];
    } else {
        _bottomView.hidden = YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
    }
}

- (void)setupBottomView {
    CGFloat bottom = IS_IPHONE_X ? 34 : 0;
    bottom += 20;
    _bottomView = [DYZCacheListBottomView new];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    _bottomView.hidden = YES;
    
    [_bottomView.selectedButton addTarget:self
                                   action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView.deleteButton addTarget:self
                                 action:@selector(deleteAction)
                       forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)deleteAction {
    _deleteRequest = [APIDeleteCollection new];
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray *courses = [NSMutableArray new];
    for (NSInteger i = 0; i < self.models.count; ++i) {
        CollectionCourse *course = self.models[i];
        if (course.isSelected) {
            [array addObject:course.ID];
            [courses addObject:course];
        }
    }
    _deleteRequest.courseId = array;
    
    [_deleteRequest startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        [self.view makeToast:@"取消关注成功"
                    duration:1
                    position:CSToastPositionCenter];
        [self.models removeObjectsInArray:courses];
        [self.tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)selectedButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        for (NSInteger i = 0; i < self.models.count; ++i) {
            CollectionCourse *course = self.models[i];
            course.isSelected = YES;
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    } else {
        for (NSInteger i = 0; i < self.models.count; ++i) {
            CollectionCourse *course = self.models[i];
            course.isSelected = YES;
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:path animated:YES];
        }
    }
}


- (void)requestNews {
    __weak typeof(self) _self = self;
    
    [_request startPostWithSuccessBlock:^(ResponseMyCollectionList *response, NSDictionary *options) {
        _self.response = response;
        
        if (_self.request.currPage == 1) {
            [self.models removeAllObjects];
        }
        
        [self.models addObjectsFromArray:_response.content];
        [_self.tableView reloadData];

    } failBlock:^(LYNetworkError *error, NSDictionary *options) {

    }];
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[DYZMyCollectionCell class] forCellReuseIdentifier:@"cell"];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    __weak typeof(self) _self = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_self.tableView.mj_footer.state == MJRefreshStateNoMoreData) {
            [_self.tableView.mj_footer resetNoMoreData];
        }
        _self.request.currPage = 1;
        [_self requestNews];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _self.request.currPage += 1;
        [_self requestNews];
    }];
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.models.count) {
        CollectionCourse *course = self.models[indexPath.row];
        [cell setCollectionCourse:course];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCourse *course = self.models[indexPath.row];
    course.isSelected = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCourse *course = self.models[indexPath.row];
    course.isSelected = YES;
    if (!_isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self openWebPageWithUrlString:course.url];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

@end
