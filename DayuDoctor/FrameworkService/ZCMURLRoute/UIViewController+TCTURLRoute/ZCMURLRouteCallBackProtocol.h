//
//  ZCMURLRouteCallBackProtocol.h
//  ZCMURLRoute
//


#import <Foundation/Foundation.h>

@protocol ZCMURLRouteCallBackProtocol <NSObject>

@optional

/**
 *  route回调数据，A->URLRoute[->Hold]->B，则A需要实现
 *
 *  @param callback B页面回传的数据
 */
- (void)routeCallBackWithParam:(NSDictionary *)callback;

@end
