//
//  APIUpdateUserInfo.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/16.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIUpdateUserInfo : LYRequestObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *goodtypes;

@end

NS_ASSUME_NONNULL_END
