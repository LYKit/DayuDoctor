//
//  UIViewController+ZCMURLRoute.h
//  ZCMURLRoute
//
//  Created by 赵学良 on 2018/9/24.
//  Copyright © 2018年 zhaoxueliang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZCMURLRoutePopProtocol.h"
#import "ZCMURLRoutePushProtocol.h"

/** URL规则处理失败 */
extern NSString * const ZCMURLRouteHandleErrorNotification;
/** URL规则处理完成 */
extern NSString * const ZCMURLRouteHandleCompleteNotification;

typedef void(^ZCMURLRouteOpenCompletion)(void); //->kURLRouteOpenCompletion
typedef void(^ZCMURLRouteOpenLoginCompletionBlock)(BOOL isLogin, NSDictionary *options);

extern NSString *const kURLRouteOpenAnimated;           //是否需要动画，默认@YES
extern NSString *const kURLRouteOpenAnimatedTransition; //动画形式，默认@(URLRouteOpenAnimatedPush)
extern NSString *const kURLRouteOpenCompletion;         //完成后回调操作，默认nil

typedef NS_ENUM(NSUInteger, URLRouteOpenAnimatedTransition) {
    URLRouteOpenAnimatedPush, 
    URLRouteOpenAnimatedPresent
};

@interface UIViewController (ZCMURLRoute) <ZCMURLRoutePopProtocol, ZCMURLRoutePushProtocol>

/**
 *
 *  @param url      例如：scheme://module/page[?][key=value&key=value]
 *  @param options  自定义kURLRouteOpen参数
 *  parameter 除了url参数外，其他需要传递的参数
 */
- (void)openRouteURL:(NSURL *)url options:(NSDictionary *)options parameter:(NSDictionary *)parameter;

@end

@interface UIViewController (ZCMURLRouteCompatible)

/**
 *  aString  例如：scheme://module/page[?][key=value&key=value]
 *  options  自定义kURLRouteOpen参数,跳转配置
 *  parameter 除了url参数外，其他需要传递的参数
 */
- (void)openRouteURLString:(NSString *)aString options:(NSDictionary *)options;
- (void)openRouteURLString:(NSString *)aString parameter:(NSDictionary *)parameter;
- (void)openRouteURLString:(NSString *)aString parameter:(NSDictionary *)parameter options:(NSDictionary *)options;

/**
 @param module 模块名
 @param page 页面
 @param parameter 传递参数
 */
- (void)openRouteWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter;

@end

@interface UIViewController (ZCMURLRouteHoldObject)

/**
 *  维持处理Hold的对象的生命周期
 *  需要重新获取则使用NSDictionary
 *  只需要位置使用NSArray
 *  默认NSObject
 */
@property (nonatomic, strong) id holdObject;

@end
