//
//  APIOrdersDetail.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"


@interface APIOrdersDetail : LYRequestObject
@property (nonatomic, copy) NSString *rid;


@end



@interface OrdersDetail : NSObject
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *doctorName;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *orderDate;

@end

@interface ResponseOrdersDetail : LYResponseObject
@property (nonatomic, strong) OrdersDetail *detail;

@end
