//
//  ZCMURLRoutePushProtocol.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

extern NSString * const URLRouteVersion;

@protocol ZCMURLRoutePushProtocol

@optional

/**
 *  url路由跳转时，对viewcontroller进行数据配置
 *
 *  @param params 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
 */
- (void)routeWillPushControllerWithParam:(NSDictionary *)params;

/**
 *  页面push跳转后调用
 *
 *  @param params 传入的url字典数据，包括处理后url的key： kRouteConfigureFormatUrlKey 以及页面具体参数
 */
- (void)routeDidPushControllerWithParam:(NSDictionary *)params;

@end
