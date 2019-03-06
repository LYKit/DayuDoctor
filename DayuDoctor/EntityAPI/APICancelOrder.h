//
//  APICancelOrder.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APICancelOrder : LYRequestObject

@property (nonatomic, copy) NSString *transId;


@end

NS_ASSUME_NONNULL_END
