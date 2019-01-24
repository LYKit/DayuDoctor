//
//  APIHomeCourseList.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIHomeCourseList : LYRequestObject



@end


@interface CourseModel : NSObject
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;


@end


@interface ResponseHomeCourseList : LYResponseObject

@property (nonatomic, strong) NSMutableArray<CourseModel *> *coursesList;

@end

NS_ASSUME_NONNULL_END
