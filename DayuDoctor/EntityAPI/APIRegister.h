//
//  APIRegister.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIRegister : LYRequestObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userpwd;
@property (nonatomic, copy) NSString *validateCode;

@end

NS_ASSUME_NONNULL_END
