//
//  NSURL+ZCMURLChar.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@interface NSURL (ZCMURLChar)

/** scheme是否为设置的值，默认 [DYZRouteConfig routeSchemeNative] */
- (BOOL)isRouteScheme;

@end
