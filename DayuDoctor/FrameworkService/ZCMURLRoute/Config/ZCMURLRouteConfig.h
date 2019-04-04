//
//  ZCMURLRouteConfig.h
//  ZCMURLRoute
//


#import <Foundation/Foundation.h>

extern NSString * const kRouteConfigClass;      //page ClassName
extern NSString * const kRouteConfigBundle;     //nib BundleName
extern NSString * const kRouteConfigNib;        //page NibName

extern NSString * const kRouteConfigHold;       //拦截器集合
extern NSString * const kRouteConfigCheckKeys;  //检查需要的属性是否存在
extern NSString * const kRouteConfigPassKeys;   //相同property值往下传
extern NSString * const kRouteConfigWantLocation;  //拦截判断是否已定位

@interface ZCMURLRouteConfig : NSObject

+ (instancetype)defaultRouteConfig;

/** 添加更多的页面规则，规则只能增加、覆盖，不能移除
 *  @param routeDictionary 页面规则集合
 */
+ (void)addRouteDictionary:(NSDictionary *)routeDictionary;

/**
 *  根据Plist名称加载Route
 *  param plists [[[NSBundle mainBundle] pathForResource:@"Route" ofType:@"plist"], [[NSBundle mainBundle] pathForResource:@"Route" ofType:@"plist"]...]
 */
+ (void)addRouteWithPlistPath:(NSString *)path;
+ (void)addRouteWithPlistPaths:(NSArray *)paths;

/** 现有的页面规则 */
+ (NSDictionary *)routeDictionary;

/** 自定义Native的Scheme */
+ (void)registerURLRouteNativeScheme:(NSString *)scheme;

@end
