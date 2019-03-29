//
//  NSDictionary+URLCode.h
//  bangjob
//
//  Created by 赵学良 on 2018/12/26.
//  Copyright © 2018年 com.58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (URLQuery)

/**
 *  根据URL.query查询参数的值
 *
 *  @param query URL.query
 *
 *  @return dictionary
 */
+ (instancetype)dictionaryWithURLQuery:(NSString *)query;

@end
