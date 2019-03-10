//
//  APIOrderList.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/4.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIOrderList : DYZRequestObject
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;


@end


@interface OrderModel : NSObject
@property (nonatomic, copy) NSString *transId;
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *status; // 0 未支付  1已支付
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *payUrl;

@end


@interface ResponseOrderList : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray *list;


@end

NS_ASSUME_NONNULL_END
