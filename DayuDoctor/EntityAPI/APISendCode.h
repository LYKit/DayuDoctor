//
//  APISendCode.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface APISendCode : DYZRequestObject

@property (nonatomic, copy) NSString *mobile;

@end



NS_ASSUME_NONNULL_END
