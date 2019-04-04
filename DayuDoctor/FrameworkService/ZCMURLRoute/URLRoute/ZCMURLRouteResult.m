//
//  ZCMURLRouteResult.m
//  ZCMURLRoute
//

#import "ZCMURLRouteResult.h"
#import "ZCMRouteScheme.h"
#import "DYZRouteConfig.h"

NSString * const kRouteResultLastViewController = @"kRouteResultLastViewController";
NSString * const kRouteResultUseableURL = @"kRouteResultUseableURL";
NSString * const kRouteResultOriginalURL = @"kRouteResultOriginalURL";
NSString * const kRouteOriginalURLString = @"kRouteOriginalURLString";

@interface ZCMURLRouteResult ()

@property (nonatomic, assign, readwrite) ZCMURLRouteOpenType openType;

@end

@implementation ZCMURLRouteResult

- (instancetype)initWithScheme:(NSString *)scheme {
    self = [self init];
    if (self) {
        if ([scheme isEqualToString:[ZCMRouteScheme nativeScheme]]) {
            self.openType = URLRouteOpenNative;
        }
        else if ([scheme isEqualToString:[DYZRouteConfig routeSchemeExternal]]) {
            self.openType = URLRouteOpenExternal;
        }
        else if ([scheme isEqualToString:[DYZRouteConfig routeSchemeWeb]] ||
                 [scheme isEqualToString:[DYZRouteConfig routeSchemeFile]] ||
                 [scheme isEqualToString:[DYZRouteConfig routeSchemeSECWeb]]) {
            self.openType = URLRouteOpenWeb;
        }
        else {
            self.openType = URLRouteOpenUndefine;
        }
    }
    return self;
}

@end
