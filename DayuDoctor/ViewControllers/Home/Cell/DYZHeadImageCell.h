//
//  DYZHeadImageCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHomeBanner.h"


static NSString * const kDYZHeadImageCell = @"DYZHeadImageCell";


NS_ASSUME_NONNULL_BEGIN

@interface DYZHeadImageCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *bannerList;


@end

NS_ASSUME_NONNULL_END
