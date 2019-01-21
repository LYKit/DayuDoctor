//
//  DYZRequestCoursesList.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYZRequestCoursesList : LYRequestObject
@property (nonatomic, copy) NSString *currPage;
@property (nonatomic, copy) NSString *pageSize;
@end

NS_ASSUME_NONNULL_END
