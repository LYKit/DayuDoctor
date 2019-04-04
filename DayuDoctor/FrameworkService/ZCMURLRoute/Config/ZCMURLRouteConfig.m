//
//  ZCMURLRouteConfig.m
//  ZCMURLRoute
//

#import "ZCMURLRouteConfig.h"

NSString * const kRouteConfigClass      = @"_class";
NSString * const kRouteConfigBundle     = @"_bundle";
NSString * const kRouteConfigNib        = @"_nib";

NSString * const kRouteConfigHold       = @"_hold";
NSString * const kRouteConfigWantHybrid = @"_hybrid";
NSString * const kRouteConfigCheckKeys  = @"_checkKeys";
NSString * const kRouteConfigPassKeys   = @"_passKeys";

@interface ZCMURLRouteConfig ()

@property (nonatomic, strong) NSMutableDictionary *p_routeDictionary;
@property (nonatomic, strong) NSString *nativeScheme;

@end

@implementation ZCMURLRouteConfig

+ (instancetype)defaultRouteConfig {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    return instance;
}

+ (void)addRouteDictionary:(NSDictionary *)routeDictionary {
    if ([routeDictionary isKindOfClass:[NSDictionary class]]) {
        [routeDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            ZCMURLRouteConfig *routeConfig = [ZCMURLRouteConfig defaultRouteConfig];
            NSMutableDictionary *oldDict = [routeConfig.p_routeDictionary[key] mutableCopy] ?: [NSMutableDictionary dictionary];
            NSDictionary *newDict = routeDictionary[key];
            if (newDict) {
                [oldDict addEntriesFromDictionary:newDict];
            }
            if (oldDict) {
                routeConfig.p_routeDictionary[key] = oldDict;
            }
        }];
    }
}

+ (void)addRouteWithPlistPath:(NSString *)path {
    if ([path isKindOfClass:[NSString class]]) {
        NSData *plistData = [NSData dataWithContentsOfFile:path];
        if (plistData) {
            NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plistData
                                                                                 options:NSPropertyListImmutable
                                                                                  format:nil
                                                                                   error:nil];
            [self addRouteDictionary:dictionary];
        }
        else {
            NSAssert(plistData, ([NSString stringWithFormat:@"%@文件不存在", path]));
        }
    }
}

+ (void)addRouteWithPlistPaths:(NSArray *)paths {
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addRouteWithPlistPath:obj];
    }];
}

+ (NSDictionary *)routeDictionary {
    ZCMURLRouteConfig *routeConfig = [ZCMURLRouteConfig defaultRouteConfig];
    NSDictionary *routeDictionary = [routeConfig.p_routeDictionary copy];
    return routeDictionary;
}


+ (void)registerURLRouteNativeScheme:(NSString *)scheme {
    ZCMURLRouteConfig *routeConfig = [ZCMURLRouteConfig defaultRouteConfig];
    routeConfig.nativeScheme = scheme;
}

#pragma mark -
- (NSMutableDictionary *)p_routeDictionary {
    return _p_routeDictionary ?: ({
        _p_routeDictionary = [NSMutableDictionary dictionary];
    });
}

@end

