//
//  DYZHeadImageCollectionCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHomeBanner.h"


static NSString * const kHeadImageCollectionCell = @"DYZHeadImageCollectionCell";


NS_ASSUME_NONNULL_BEGIN

@interface DYZHeadImageCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *bannerList;


@end

NS_ASSUME_NONNULL_END
