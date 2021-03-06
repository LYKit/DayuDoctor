//
//  DYZNewsTableCell.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZBaseTableViewCell.h"
#import "APINewsList.h"


NS_ASSUME_NONNULL_BEGIN

@interface DYZNewsTableCell : DYZBaseTableViewCell

- (void)setNews:(News *)news;

@end

NS_ASSUME_NONNULL_END
