//
//  APICourseItem.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/9.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
@interface APICourseItem : DYZRequestObject
@property (nonatomic, copy) NSString *id;

@end



@interface CourseItem : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *exist;
@property (nonatomic, copy) NSString *freeFlag;
@property (nonatomic, copy) NSString *buy;
@property (nonatomic, copy) NSString *play;
@end


@interface ResponseCourseItem : LYResponseObject
@property (nonatomic, strong) NSArray<CourseItem *> *items;
@end



