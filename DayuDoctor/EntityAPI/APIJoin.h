//
//  APIJoin.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIJoin : DYZRequestObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *address;


@end

NS_ASSUME_NONNULL_END
