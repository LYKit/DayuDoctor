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
#import <MessageUI/MessageUI.h>

@interface DYZShareViewController ()<MFMessageComposeViewControllerDelegate>
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
    [self.view addSubview:_qrImgView];
    [_qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    _qrImgView.image = [UIImage imageNamed:@"qrimg.jpeg"];
    
    NSMutableArray *buttons = [NSMutableArray new];
    NSArray *titles = @[@"新浪微博", @"微信好友", @"微信朋友圈", @"短信"];
    NSArray *images = @[@"icon_weibo.jpg", @"icon_wechat.jpg", @"icon_friend.jpg", @"icon_sms.jpg"];
    for (NSInteger i = 0; i < titles.count; ++i) {
        DYZShareButton *button = [DYZShareButton new];
        button.userInteractionEnabled = YES;
        NSString *title = titles[i];
        button.titleLabel.text = title;
        UIImage *image = [UIImage imageNamed:images[i]];
        button.imageView.image = image;
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

- (NSData *)getQRCodeData {
    NSData *imgData = [_qrImgView.image imageDataRepresentation];
    return imgData;
}

- (void)shareToPlatform:(JSHAREPlatform)platform {
    if (   platform == JSHAREPlatformWechatSession
        || platform == JSHAREPlatformWechatTimeLine) {
        if ([JSHAREService isWeChatInstalled] == NO) {
            [self.view makeToast:@"没有安装微信"
                        duration:1
                        position:CSToastPositionCenter];
            return;
        }
    }
    NSString *iconName = [[[[NSBundle mainBundle] infoDictionary]valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *icon = [UIImage imageNamed:iconName];
    JSHAREMessage *message = [JSHAREMessage message];
    message.title = @"大禹中元分享";
    message.text = @"我发现了一块非常好用的APP：大禹中元，快来下载使用吧";
    message.url = @"www.dyzy58.com";
    message.platform = platform;
    message.mediaType = JSHARELink;
    message.image = [icon imageDataRepresentation];
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
        if (!error) {
            [self.view makeToast:@"分享成功"
                        duration:1
                        position:CSToastPositionCenter];
        }
    }];
}

- (void)shareToMessage {
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.messageComposeDelegate = self;
        NSString *body = @"我发现了一块非常好用的APP：大禹中元，快来下载使用吧 www.dyzy58.com";
        BOOL isSuccess = [controller addAttachmentData:[self getQRCodeData]
                                        typeIdentifier:@"image/jpg"
                                              filename:@"1.png"];
        controller.body = body;
        if (!isSuccess) {
            NSLog(@"添加图片失败");
        }
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            [controller dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultSent:
            [controller dismissViewControllerAnimated:YES completion:nil];
            [self.view makeToast:@"分享成功"
                        duration:1
                        position:CSToastPositionCenter];
            break;
        case MessageComposeResultFailed:
            [controller dismissViewControllerAnimated:YES completion:nil];
            [self.view makeToast:@"分享失败"
                        duration:1
                        position:CSToastPositionCenter];
            break;
        default:
            break;
    }
}

- (void)buttonAction:(DYZShareButton *)button {
    switch (button.tag) {
        case 0: {
            [self shareToPlatform:JSHAREPlatformSinaWeibo];
        } break;
            
        case 1: {
            [self shareToPlatform:JSHAREPlatformWechatSession];
        } break;

        case 2: {
            [self shareToPlatform:JSHAREPlatformWechatTimeLine];
        } break;

        case 3: {
            [self shareToMessage];
        } break;
            
        default:
            break;
    }
}


@end
