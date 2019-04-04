//
//  ZCMURLBridge.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@interface ZCMURLBridge : NSObject

/**
 *  aSting url String
 */
+ (NSURL *)routeURLFromString:(NSString *)aString;

/**
 *  自定义生成URL规则
 *
 *  @param module    模块
 *  @param page      页面
 *  @param parameter 参数
 *
 *  @return URL2.0规则
 */
+ (NSURL *)routeURLWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter;


@end
