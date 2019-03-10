//
//  APIRecomcode.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"


@interface APIRecomcode : DYZRequestObject

@end

@interface ResponseRecomcode : LYResponseObject
@property (nonatomic, copy) NSString *recomcode;
@property (nonatomic, copy) NSString *num;

@end
