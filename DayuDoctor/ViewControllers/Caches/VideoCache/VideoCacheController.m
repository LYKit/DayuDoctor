//
//  VideoCacheController.m
//  YCDownloadSession
//
//  Created by wz on 17/3/23.
//  Copyright © 2017年 onezen.cc. All rights reserved.
//

#import "VideoCacheController.h"
#import "VideoCacheListCell.h"
#import "YCDownloadManager.h"
#import "DYZCacheListBottomView.h"

static NSString * const kDefinePauseAllTitle = @"暂停所有";
static NSString * const kDefineStartAllTitle = @"开始所有";

@interface VideoCacheController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cacheVideoList;

@property (nonatomic, strong) UIButton *pasueButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) DYZCacheListBottomView *bottomView;

@end

@implementation VideoCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupOperateButton];
    [self setupTableView];
    self.title = @"缓存";
    self.view.backgroundColor = [UIColor whiteColor];
    self.cacheVideoList = [NSMutableArray array];
    [self getCacheVideoList];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.cacheVideoList.count > 0 ?  kDefinePauseAllTitle : kDefineStartAllTitle  style:UIBarButtonItemStyleDone target:self action:@selector(pauseAll)];
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
}

- (void)setupOperateButton {
    
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
    
    
    _pasueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pasueButton.layer.cornerRadius = 5;
    _pasueButton.layer.masksToBounds = YES;
    _pasueButton.backgroundColor = [UIColor blackColor];
    _pasueButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pasueButton setTitle:@"全部暂停" forState:UIControlStateNormal];
    [_pasueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_pasueButton];
    [_pasueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editButton);
        make.right.equalTo(_editButton.mas_left).mas_offset(-10);
        make.width.mas_equalTo(100);
    }];
    [_pasueButton addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editAction {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    BOOL isEditing = self.tableView.editing;
    if (isEditing) {
        _bottomView.hidden = NO;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_bottomView.mas_top);
        }];
    } else {
        _bottomView.hidden = YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
    }
}

- (void)pauseAction:(UIButton *)button {
    
}


- (void)getCacheVideoList {
    
    [self.cacheVideoList removeAllObjects];
    [self.cacheVideoList addObjectsFromArray:[YCDownloadManager downloadList]];
    [self.cacheVideoList addObjectsFromArray:[YCDownloadManager finishList]];
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = self.cacheVideoList.count>0;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
        ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pasueButton.mas_bottom).mas_offset(5);
        make.left.right.equalTo(self.view);
        CGFloat bottom = IS_IPHONE_X ? 34 : 0;
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    
    [self setupBottomView];
}

- (void)pauseAll {
    if (self.navigationItem.rightBarButtonItem.title == kDefinePauseAllTitle) {
        [YCDownloadManager pauseAllDownloadTask];
        self.navigationItem.rightBarButtonItem.title = kDefineStartAllTitle;
    }else{
        if (self.startAllBlk && self.cacheVideoList.count==0) {
            self.startAllBlk();
            [self getCacheVideoList];
        }else{
            [YCDownloadManager resumeAllDownloadTask];
            self.navigationItem.rightBarButtonItem.title = kDefinePauseAllTitle;
        }
    }
}

#pragma mark - uitableview datasource & delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        YCDownloadItem *item = _cacheVideoList[indexPath.row];
        [YCDownloadManager stopDownloadWithItem:item];
        
        [self.cacheVideoList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCacheListCell *cell = [VideoCacheListCell videoCacheListCellWithTableView:tableView];
    YCDownloadItem *item = self.cacheVideoList[indexPath.row];
    cell.item = item;
    item.delegate = cell;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cacheVideoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoCacheListCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YCDownloadItem *item = self.cacheVideoList[indexPath.row];
    if (item.downloadStatus == YCDownloadStatusDownloading) {
        [YCDownloadManager pauseDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusPaused){
        [YCDownloadManager resumeDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusFailed){
        [YCDownloadManager resumeDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusWaiting){
        [YCDownloadManager pauseDownloadWithItem:item];
    }else if (item.downloadStatus == YCDownloadStatusFinished){
//        PlayerViewController *playerVC = [[PlayerViewController alloc] init];
//        playerVC.playerItem = item;
//        [self.navigationController pushViewController:playerVC animated:true];
    }
    [self.tableView reloadData];
}


@end
