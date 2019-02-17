//
//  APIFaceTeach.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIFaceTeach : LYRequestObject

@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;

@end


@interface FaceTeachModel : NSObject
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;


@end


@interface ResponseFaceTeach : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<FaceTeachModel *> *content;


@end

NS_ASSUME_NONNULL_END
