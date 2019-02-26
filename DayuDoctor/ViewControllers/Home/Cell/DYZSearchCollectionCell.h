//
//  DYZSearchCollectionCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kDYZSearchCollectionCell = @"DYZSearchCollectionCell";

@interface DYZSearchCollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSString *strTitle;

+ (CGSize)cellSize:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
