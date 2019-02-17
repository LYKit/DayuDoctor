//
//  DYZFaceTeachCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIFaceTeach.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kDYZFaceTeachCell = @"DYZFaceTeachCell";

@interface DYZFaceTeachCell : UITableViewCell

@property (nonatomic, strong) FaceTeachModel *model;


@end

NS_ASSUME_NONNULL_END
