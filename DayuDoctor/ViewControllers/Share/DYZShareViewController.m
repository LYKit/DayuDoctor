//
//  DYZShareViewController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZShareViewController.h"
#import "DYZShareButton.h"
#import <JSHAREService.h>

@interface DYZShareViewController ()
@property (nonatomic, strong) UIImageView *qrImgView;

@end

@implementation DYZShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分享";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
}


- (void)setupView {
    UILabel *label = [UILabel new];
    label.text = @"扫一扫推荐好用使用";
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    _qrImgView = [UIImageView new];
    _qrImgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_qrImgView];
    [_qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSMutableArray *buttons = [NSMutableArray new];
    NSArray *titles = @[@"新浪微博", @"微信好友", @"微信朋友圈", @"短信"];
    for (NSInteger i = 0; i < 4; ++i) {
        DYZShareButton *button = [DYZShareButton new];
        button.userInteractionEnabled = YES;
        NSString *title = titles[i];
        button.titleLabel.text = title;
        [self.view addSubview:button];
        [buttons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_qrImgView.mas_bottom).mas_offset(30);
            make.height.mas_equalTo(70);
        }];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                      withFixedItemLength:70
                              leadSpacing:10
                              tailSpacing:10];

}

- (void)shareToWeiBo {
    JSHAREMessage *message = [JSHAREMessage message];
    message.text = @"JShare SDK 支持主流社交平台、帮助开发者轻松实现社会化功能！";
    message.platform = JSHAREPlatformSinaWeibo;
    message.mediaType = JSHAREText;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
    }];
}

- (void)buttonAction:(DYZShareButton *)button {
    switch (button.tag) {
        case 0: {
            [self shareToWeiBo];
        } break;
            
        case 1: {
            
        } break;

        case 2: {
            
        } break;

        case 3: {
            
        } break;

            
        default:
            break;
    }
}


@end
