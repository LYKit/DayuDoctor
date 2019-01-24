//
//  DYZClassifyCollectionCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClassify.h"

static NSString * const kClassifyCollectionCell = @"DYZClassifyCollectionCell";


NS_ASSUME_NONNULL_BEGIN

@interface DYZClassifyCollectionCell : UICollectionViewCell

@property (nonatomic, strong) ClassifyModel *model;


@end

NS_ASSUME_NONNULL_END
