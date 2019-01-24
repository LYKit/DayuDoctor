//
//  DYZVideoCollectionCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHomeCourseList.h"

static NSString * const kVideoCollectionCell = @"DYZVideoCollectionCell";

NS_ASSUME_NONNULL_BEGIN

@interface DYZVideoCollectionCell : UICollectionViewCell

@property (nonatomic, strong) CourseModel *model;


@end

NS_ASSUME_NONNULL_END
