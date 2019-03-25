//
//  PlayerViewController.m
//  YCDownloadSession
//
//  Created by wz on 2017/9/30.
//  Copyright © 2017年 onezen.cc. All rights reserved.
//

#import "PlayerViewController.h"
#import "WMPlayer.h"
#import "VideoListInfoModel.h"
#import "GKCommon.h"
#import "YCDownloadManager.h"
#import "VideoCacheController.h"
#import "VideoListInfoModel.h"


@interface PlayerViewController ()<WMPlayerDelegate>

@property (nonatomic, strong) WMPlayer *player;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *directoryButton;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.originalFrame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.player = [[WMPlayer alloc] init];
    self.player.delegate = self;
    self.player.backBtnStyle = BackBtnStyleNone;
    [self.view addSubview:_player];
    
    NSURL *url = nil;
    if (_playMode == PlayerModeLocal) {
        url = [NSURL fileURLWithPath:self.playerItem.savePath];
        VideoListInfoModel *infoMo = [VideoListInfoModel infoWithData:self.playerItem.extraData];
        self.title = infoMo.title;
    } else if (_playMode == PlayerModeOnline) {
        NSString *urlstring = [NSString stringWithFormat:@"%@id=%@",kVideoURL, self.onlineURL];
        url = [NSURL URLWithString:urlstring];
        _url = urlstring;
    } else {
        url = [NSURL URLWithString:@""];
    }
    //保存路径需要转换为url路径，才能播放
    NSLog(@"[playViewVC] videoUrl:%@", url);
    
    WMPlayerModel *model = [[WMPlayerModel alloc] init];
    model.videoURL = url;
    _player.playerModel = model;
    [_player play];
    
    
    [self setupView];
}

- (void)dealloc {
    [_player pause];
    [_player removeFromSuperview];
}

- (UIButton *)getButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor lightGrayColor];
    UIColor *color = [UIColor blackColor];
    [button setTitleColor:color
                 forState:UIControlStateNormal];
    return button;
}

- (void)directoryButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadButtonAction {
    VideoListInfoModel *model = [VideoListInfoModel new];
    model.title = [NSString stringWithFormat:@"%@ - %@", self.videoName, self.onlineURL];
    model.video_url = _url;
    YCDownloadItem *item = [[YCDownloadItem alloc] initWithUrl:_url fileId:@"1000"];
    item.enableSpeed = YES;
    item.extraData = [VideoListInfoModel dateWithInfoModel:model];
    [YCDownloadManager startDownloadWithItem:item];
}

- (void)setupView {
    CGFloat bottom = 20;
    if (GK_IS_iPhoneX) {
        bottom = 34;
    }
    
    CGFloat width = (kScreenWidth - 20 - 2 * 20) / 3;
    self.backButton = [self getButton];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    [self.backButton addTarget:self
                        action:@selector(directoryButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.directoryButton addTarget:self
                             action:@selector(directoryButtonAction) forControlEvents:UIControlEventTouchUpInside];

    self.downloadButton = [self getButton];
    [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [self.view addSubview:self.downloadButton];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right).mas_offset(20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    [self.downloadButton addTarget:self
                            action:@selector(downloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.directoryButton = [self getButton];
    [self.directoryButton setTitle:@"目录" forState:UIControlStateNormal];
    [self.view addSubview:self.directoryButton];
    [self.directoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downloadButton.mas_right).mas_offset(20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    [self.directoryButton addTarget:self
                            action:@selector(directoryButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark rotate

/**
 *  旋转屏幕的时候，是否自动旋转子视图，NO的话不会旋转控制器的子控件
 *
 */
- (BOOL)shouldAutorotate
{
    return true;
}

/**
 *  当前控制器支持的旋转方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft  ;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if (self.player.isFullscreen)
        return UIInterfaceOrientationPortrait;
    return UIInterfaceOrientationLandscapeRight ;
}

/**
 需要切换的屏幕方向，手动转屏
 */
- (void)setFullScreen:(BOOL)isFullScreen {
    
    if (isFullScreen) {
        self.backButton.hidden = YES;
        self.directoryButton.hidden = YES;
        self.downloadButton.hidden = YES;
        [self rotateOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        self.backButton.hidden = NO;
        self.directoryButton.hidden = NO;
        self.downloadButton.hidden = NO;
        [self rotateOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)rotateOrientation:(UIInterfaceOrientation)orientation {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:YES];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation] forKey:@"orientation"];
}

//自动转屏或者手动调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    self.isFullScreen = size.width > size.height;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.isFullScreen){
            
//        [self.navigationController setNavigationBarHidden:true];
        self.player.frame = self.view.bounds;
        self.player.isFullscreen = true;
    }else{
//        [self.navigationController setNavigationBarHidden:false];
        self.player.frame = self.originalFrame;
        self.player.isFullscreen = false;
    }
}

#pragma mark - player view delegate


//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"%s", __func__);
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    
    if (self.player.isFullscreen) {
        [self setFullScreen:false];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    [self setFullScreen:!self.player.isFullscreen];
}
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"%s", __func__);
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"%s", __func__);
}
//WMPlayer的的操作栏隐藏和显示
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL )isHidden{
    NSLog(@"%s", __func__);
}
///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"%s", __func__);
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"%s", __func__);
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"%s", __func__);
}


@end



