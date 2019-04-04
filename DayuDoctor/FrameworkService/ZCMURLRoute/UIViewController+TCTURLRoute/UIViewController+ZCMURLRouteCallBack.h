//
//  UIViewController+ZCMURLRouteCallBack.h
//  ZCMURLRoute
//


#import <UIKit/UIKit.h>

/** B -> A参数中包含B的class，告诉A回调来源类 */
extern NSString *ZCMURLRouteCallBackSourceClass;

@interface UIViewController (ZCMURLRouteCallBack)

/** 需要回调的ViewController
 *  A->URLRoute->B，默认会设置B的routeCallBackViewController为A
 *  A->URLRoute->Hold->B，需在Hold中设置B routeCallBackViewController为A
 *  A需要实现 protocol ZCMURLRouteCallBackProtocol
 */
@property (nonatomic, weak) UIViewController *routeCallBackViewController;

/**
 *  route回调数据，A->URLRoute[->Hold]->B，则B在需要传参数给A时调用
 *
 *  @param callback 传给A的数据，可能包含ZCMURLRouteCallBackSourceClass参数
 */
- (void)routeCallBack:(NSDictionary *)callback;

@end
