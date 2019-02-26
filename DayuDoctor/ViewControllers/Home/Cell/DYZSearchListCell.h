//
//  DYZSearchListCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APISearchList.h"

static NSString * const kDYZSearchListCell = @"DYZSearchListCell";

NS_ASSUME_NONNULL_BEGIN

@interface DYZSearchListCell : UITableViewCell

@property (nonatomic, strong) SearchModel *model;


@end

NS_ASSUME_NONNULL_END
