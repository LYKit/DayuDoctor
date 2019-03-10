//
//  APISignUpDetail.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"

@interface APISignUpDetail : DYZRequestObject


@end




@interface SignUpDetail : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *goodtypes;// 小二中医这些
@property (nonatomic, copy) NSString *flag;     // 是否提交资料 1已提交 0未提交
@property (nonatomic, copy) NSString *signup;   // 是否报名 1是 0否
@property (nonatomic, copy) NSString *amount;   // 报名费
@property (nonatomic, copy) NSString *remark;   // 备注
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *payUrl;


@end


@interface ResponseSignUpDetail : LYResponseObject
@property (nonatomic, strong) SignUpDetail *detail;


@end

