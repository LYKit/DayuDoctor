//
//  APICourseDetail.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/8.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"

@interface APICourseDetail : DYZRequestObject
@property (nonatomic, copy) NSString *id;

@end



@interface CourseDetail : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *buynum;
@property (nonatomic, copy) NSString *details; // 0 未支付  1已支付
@property (nonatomic, copy) NSString *follow;
@property (nonatomic, copy) NSString *buy;
@end


@interface ResponseCourseDetail : LYResponseObject
@property (nonatomic, strong) CourseDetail *detail;
@end

