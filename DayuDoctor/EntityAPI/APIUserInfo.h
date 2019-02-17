//
//  APIUserInfo.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/15.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIUserInfo : LYRequestObject

@end


@interface UserInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *goodtypes; // 小二中医这些
@property (nonatomic, copy) NSString *flag; // 是否提交资料
@property (nonatomic, copy) NSString *signup; // 是否报名

@end

@interface ResponseUserInfo : LYResponseObject

@property (nonatomic, strong) UserInfo *detail;


@end

NS_ASSUME_NONNULL_END
