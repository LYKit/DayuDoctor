//
//  ZFNoramlViewController.m
//  ZFPlayer
//
//  Created by 紫枫 on 2018/3/21.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFNoramlViewController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "YCDownloadManager.h"
#import "VideoCacheController.h"
#import "VideoListInfoModel.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface ZFNoramlViewController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIButton *fileBtn;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@property (nonatomic, copy) NSString *videoUrl;

@end

@implementation ZFNoramlViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushNewVC)];
    
    [self setupView];
    [self setupPlayer];
    [YCDownloadManager removeAllCache];
}

- (void)setupView {
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        make.top.equalTo(self.view).mas_offset(0);
        make.left.right.equalTo(self.view);
        CGFloat h = kScreenWidth * 9 / 16;
        make.height.mas_equalTo(h);
    }];
    [self.containerView addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.containerView);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.view addSubview:self.downBtn];
    CGFloat bottom = IS_IPHONE_X ? 34 : 0;
    [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(bottom + 50));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth / 2);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.fileBtn];
    [self.fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(bottom + 50));
        make.left.equalTo(self.downBtn.mas_right);
        make.width.mas_equalTo(kScreenWidth / 2);
        make.height.mas_equalTo(50);
    }];
}

- (void)setupPlayer {
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        //        [self.player playTheNext];
        //        if (!self.player.isLastAssetURL) {
        //            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
        //            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        //        } else {
        //            [self.player stop];
        //        }
        //        [self.player stop];
    };
    
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        NSLog(@"======开始播放了");
    };
    
    self.assetURLs = @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
                       [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
                       [NSURL URLWithString:@"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
                       [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
    
    self.player.assetURLs = @[[NSURL URLWithString:_videoUrl]];
}

- (void)downClick:(UIButton *)sender {
//    YCDownloadItem *item = nil;
//    if (model.vid) {
//        item = [YCDownloadManager itemWithFileId:model.vid];
//    }else if (model.video_url){
//        item = [YCDownloadManager itemsWithDownloadUrl:model.video_url].firstObject;
//    }
//    if (!item) {
//        item = [YCDownloadItem itemWithUrl:model.video_url fileId:model.vid];
//        item.extraData = [VideoListInfoModel dateWithInfoModel:model];
//        item.enableSpeed = true;
//        [YCDownloadManager startDownloadWithItem:item];
//    }
//    NSString *url = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h";
//    url = @"http://vd1.bdstatic.com/mda-hippg2tb6m76yzn5/mda-hippg2tb6m76yzn5.mp4?playlist=%5B%22hd%22%2C%22sc%22%5D&auth_key=1506245036-0-0-ad4426cc88fef724b489fd33f2346aef&bcevod_channel=pae_search";
    VideoListInfoModel *model = [VideoListInfoModel new];
    model.title = @"test";
    model.video_url = _videoUrl;
    YCDownloadItem *item = [[YCDownloadItem alloc] initWithUrl:_videoUrl fileId:@"1000"];
    item.enableSpeed = YES;
    item.extraData = [VideoListInfoModel dateWithInfoModel:model];
    [YCDownloadManager startDownloadWithItem:item];
}

- (void)fileButton:(UIButton *)sender {
    
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"视频标题" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModePortrait];
}
- (void)pushNewVC {
//    ZFSmallPlayViewController *vc = [[ZFSmallPlayViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
//    self.player.currentPlayerManager.muted = !self.player.currentPlayerManager.muted;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
//        _controlView.autoHiddenTimeInterval = 5;
//        _controlView.autoFadeTimeInterval = 0.5;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)fileBtn {
    if (!_fileBtn) {
        _fileBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_fileBtn setTitle:@"目录" forState:UIControlStateNormal];
        _fileBtn.backgroundColor = [UIColor colorWithHexString:@"#fdf1f1"];
        _fileBtn.layer.borderColor = [UIColor redColor].CGColor;
        _fileBtn.layer.borderWidth = 0.5;
        _fileBtn.layer.masksToBounds = YES;
        [_fileBtn addTarget:self action:@selector(fileButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fileBtn;
}

- (UIButton *)downBtn {
    if (!_downBtn) {
        _downBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_downBtn setTitle:@"下载" forState:UIControlStateNormal];
        _downBtn.backgroundColor = [UIColor colorWithHexString:@"#fdf1f1"];
        _downBtn.layer.borderColor = [UIColor redColor].CGColor;
        _downBtn.layer.borderWidth = 0.5;
        _downBtn.layer.masksToBounds = YES;
        [_downBtn addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downBtn;
}

- (void)setVideoId:(NSString *)videoId {
    _videoId = videoId;
    _videoUrl = [NSString stringWithFormat:@"%@id=%@",kVideoURL,videoId];
}

@end
