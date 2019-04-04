//
//  ZCMURLRouteHold.h
//  ZCMURLRoute
//


#import <Foundation/Foundation.h>
#import "ZCMURLRouteResult.h"
#import "ZCMURLRouteHoldProtocol.h"

/** parameters的一些KEY */
extern NSString * const kRouteHoldLastViewController;   //堆栈的最后一个页面控制器
extern NSString * const kRouteHoldViewController;       //URL生成的ViewController
extern NSString * const kRouteHoldParameter;            //URL生成的属性参数


typedef void (^ZCMURLRouteHoldCompleteBlock)(ZCMURLRouteResult *result, NSDictionary *options);

@interface ZCMURLRouteHold : NSObject

@property (nonatomic, strong) NSArray *checkKeys;
@property (nonatomic, strong) NSArray *passKeys;
@property (nonatomic, strong) NSString *holdController;

- (void)dealHoldWithRouteResult:(ZCMURLRouteResult *)routeResult completeBlock:(ZCMURLRouteHoldCompleteBlock)completeBlock;

@end
