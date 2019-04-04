//
//  ZCMURLRouteHoldProtocol.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@protocol ZCMURLRouteHoldProtocol <NSObject>

/**
 *  拦截URLRoute，自定义Hold
 *
 *  @param parameters 你所能得到的参数
 */
- (void)holdWithParameters:(NSDictionary *)parameters;

@end
