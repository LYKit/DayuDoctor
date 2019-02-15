//
//  DYZCoursesTableCell.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZBaseTableViewCell.h"
#import "APICoursesList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYZCoursesTableCell : DYZBaseTableViewCell

- (void)setCourse:(Course *)course;

@end

NS_ASSUME_NONNULL_END
