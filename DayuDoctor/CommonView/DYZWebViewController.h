//
//  DYZWebViewController.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "AXWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYZWebViewController : AXWebViewController

- (instancetype)initWithWebUrlString:(NSString *)urlString;

@property (nonatomic, weak) UIViewController *fromController;

@end

NS_ASSUME_NONNULL_END
