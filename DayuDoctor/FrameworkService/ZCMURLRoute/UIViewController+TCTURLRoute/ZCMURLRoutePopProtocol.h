//
//  ZCMURLRoutePopProtocol.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@protocol ZCMURLRoutePopProtocol <NSObject>

@optional

/**
 *  使用url路由返回时，对viewcontroller进行数据配置
 *
 *  @param param 传入的url字典数据，包括页面具体参数
 */
- (void)routePopOutWithParam:(NSDictionary *)param;

@end
