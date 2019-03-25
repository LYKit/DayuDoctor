//
//  PlayerViewController.h
//  YCDownloadSession
//
//  Created by wz on 2017/9/30.
//  Copyright © 2017年 onezen.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCDownloadItem.h"

typedef NS_ENUM(NSUInteger, PlayerMode) {
    PlayerModeNone,
    PlayerModeOnline,
    PlayerModeLocal,
};

@interface PlayerViewController : UIViewController

@property (nonatomic, strong) YCDownloadItem *playerItem;

@property (nonatomic, assign) PlayerMode playMode;
@property (nonatomic, strong) NSString *onlineURL;
@property (nonatomic, strong) NSString *videoName;

@end
