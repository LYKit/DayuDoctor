//
//  APICoursesList.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APICoursesList : LYRequestObject

@end


@interface Course : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *buynum;
@end

@interface ResponseCoursesList : NSObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<Course *> *content;
@end

NS_ASSUME_NONNULL_END
