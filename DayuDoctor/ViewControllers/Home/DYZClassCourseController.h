//
//  DYZClassCourseController.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZBaseViewController.h"
#import "APIClassify.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYZClassCourseController : DYZBaseViewController
@property (nonatomic, strong) ClassifyModel *classify;

@property (nonatomic, copy) NSString *classID;


@end

NS_ASSUME_NONNULL_END
