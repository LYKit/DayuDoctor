//
//  NSDictionary+URLCode.h
//  ZCMURLRoute
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
