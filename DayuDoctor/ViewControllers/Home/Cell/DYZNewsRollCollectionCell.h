//
//  DYZNewsRollCollectionCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APINewsList.h"

static NSString * const kNewsRolCollectionCell = @"DYZNewsRollCollectionCell";


NS_ASSUME_NONNULL_BEGIN

@interface DYZNewsRollCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<News *> *newsList;

@property (nonatomic, assign, readonly) NSInteger curIndex;


@end

NS_ASSUME_NONNULL_END
