//
//  APICourseClassify.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"


@interface APICourseClassify : DYZRequestObject
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *classifyId;
@end


@interface ClassifyCourse : NSObject
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *buynum;
@property (nonatomic, copy) NSString *url;
@end

@interface ResponseCourseClassify : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<ClassifyCourse *> *content;
@end
