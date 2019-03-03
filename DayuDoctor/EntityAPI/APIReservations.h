//
//  APIReservations.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/18.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIReservations : LYRequestObject
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;


@end


@interface Reservations : NSObject
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *doctorName;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *orderDate;
@property (nonatomic, copy) NSString *status; // 0 预约， 1 已完成 -1 已取消


@end

@interface ResponseReservations : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<Reservations *> *list;

@end

NS_ASSUME_NONNULL_END
