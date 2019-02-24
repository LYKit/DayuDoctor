//
//  DYZMineViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMineViewController.h"
#import "DYZMineCell.h"
#import "DYZCoursesTableController.h"
#import "DYZMyCollectionViewController.h"
#import "DYZUserInfoEditorController.h"
#import "DYZVipRightsController.h"
#import "DYZShareViewController.h"
#import "DYZMemberManager.h"
#import "DYZLoginController.h"
#import "APIUserInfo.h"

typedef enum : NSUInteger {
    enumOptionCourse = 0,
    enumOptionAppoint,
    enumOptionInfo,
    enumOptionPay,
    enumOptionOrder,
    enumOptionCollection,
    enumOptionMember,
    enumOptionScore,
    enumOptionMessage,
    enumOptionShare,
    enumOptionService,
    enumOptionUpdate,
    enumOptionOut,
} enumUserInfoOption;


@interface  MineOption: NSObject
@property (nonatomic, assign) enumUserInfoOption pos;
@property (nonatomic, copy) NSString *name;

+ (MineOption *)createOption:(NSString *)name pos:(enumUserInfoOption)pos;
@end


@implementation MineOption
+ (MineOption *)createOption:(NSString *)name pos:(enumUserInfoOption)pos
{
    MineOption *option = [MineOption new];
    option.name = name;
    option.pos = pos;
    return option;
}
@end






@interface DYZMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (nonatomic, strong) NSArray<MineOption *> *optionsList;

@property (nonatomic, strong) ResponseUserInfo *responseUserInfo;


@end

@implementation DYZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"个人中心";
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 27;
    [self.tableView registerClass:[DYZMineCell class] forCellReuseIdentifier:kDYZMineCell];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![DYZMemberManager sharedMemberManger].token.length) {
        [self.navigationController pushViewController:[DYZLoginController new] animated:NO];
    }
}


- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    [[APIUserInfo new] startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        weakSelf.responseUserInfo = responseObject;
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
}



#pragma tableView delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DYZMineCell *cell = [tableView dequeueReusableCellWithIdentifier:kDYZMineCell forIndexPath:indexPath];
    cell.strTitle = _optionsList[indexPath.row].name;
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *v = [UIView new];
//    v.layer.borderWidth = 1;
//    v.layer.borderColor = [[UIColor colorWithHexString:@"#efefef"] CGColor];
//    return v;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    switch (indexPath.row) {
        case enumOptionCourse: {
            DYZCoursesTableController *vc = [DYZCoursesTableController new];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case enumOptionAppoint: {
            
        } break;
        case enumOptionInfo: {
            DYZUserInfoEditorController *vc = [DYZUserInfoEditorController new];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case enumOptionPay: {
            
        } break;
        case enumOptionOrder: {
            
        } break;
        case enumOptionCollection: {
            DYZMyCollectionViewController *vc = [DYZMyCollectionViewController new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;

        } break;
        case enumOptionMember: {
            DYZVipRightsController *vc = [DYZVipRightsController new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } break;
        case enumOptionScore: {
            
        } break;
        case enumOptionMessage: {
            
        } break;
        case enumOptionShare: {
            DYZShareViewController *vc = [DYZShareViewController new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } break;
        case enumOptionService: {
            
        } break;
        case enumOptionUpdate: {
            
        default:
            break;
    }
    
    self.hidesBottomBarWhenPushed = NO;
    }
}




/// MARK: getter/setter
- (void)setResponseUserInfo:(ResponseUserInfo *)responseUserInfo {
    _responseUserInfo = responseUserInfo;
    _status.text = @"已登录";
    _userName.text = _responseUserInfo.detail.name.length ? _responseUserInfo.detail.name : [DYZMemberManager getMemberInfo].mobile;
}
- (NSArray *)optionsList { // 修改位置即调整枚举顺序
    if (!_optionsList) {
        NSArray *array =
  @[
    [MineOption createOption:@"我的课程" pos:enumOptionCourse],
    [MineOption createOption:@"我的预约" pos:enumOptionAppoint],
    [MineOption createOption:@"我的资料" pos:enumOptionInfo],
    [MineOption createOption:@"充值中心" pos:enumOptionPay],
    [MineOption createOption:@"我的订单" pos:enumOptionOrder],
    [MineOption createOption:@"我的收藏" pos:enumOptionCollection],
    [MineOption createOption:@"会员权益" pos:enumOptionMember],
    [MineOption createOption:@"我的积分" pos:enumOptionScore],
    [MineOption createOption:@"系统消息" pos:enumOptionMessage],
    [MineOption createOption:@"分享" pos:enumOptionShare],
    [MineOption createOption:@"在线客服" pos:enumOptionService],
    [MineOption createOption:@"版本更新" pos:enumOptionUpdate],
    [MineOption createOption:@"退出" pos:enumOptionOut]
    ];
        _optionsList = [array sortedArrayUsingComparator:^NSComparisonResult(MineOption  *obj1, MineOption *obj2) {
            return obj1.pos > obj2.pos;
        }];
    }
    return _optionsList;
}


@end




