//
//  ZCMRouteScheme.m
//  ZCMURLRoute
//

#import "ZCMRouteScheme.h"
#import "NSDictionary+URLQuery.h"
#import "NSURL+ZCMURLChar.h"
#import "NSString+RemoveUnderscoreAndInitials.h"
#import "ZCMURLRouteConfig.h"
#import "DYZRouteConfig.h"

NSString * const URLRouteVersion = @"URLRouteVersion";


@interface ZCMRouteScheme ()

@property (nonatomic, strong, readwrite) NSURL *originalURL;
@property (nonatomic, strong, readwrite) NSURL *useableURL;
@property (nonatomic, strong, readwrite) NSString *query;
@property (nonatomic, strong, readwrite) NSString *scheme;
@property (nonatomic, strong, readwrite) NSString *module;           //模块
@property (nonatomic, strong, readwrite) NSString *page;             //页面
@property (nonatomic, strong, readwrite) NSDictionary *parameter;    //参数

@end

@implementation ZCMRouteScheme

- (instancetype)initWithURL:(NSURL *)URL {
    self = [self init];
    if (self) {
        self.originalURL = URL;
        NSURL *aURL = self.originalURL;
        self.scheme = aURL.scheme;
        //根据Scheme，生成不同的属性
        if ([self.scheme isEqualToString:[ZCMRouteScheme nativeScheme]] ||
            [self.scheme isEqualToString:[DYZRouteConfig routeSchemeWeb]] ||
            [self.scheme isEqualToString:[DYZRouteConfig routeSchemeFile]] ||
            [self.scheme isEqualToString:[DYZRouteConfig routeSchemeSECWeb]]) {
            self.useableURL = aURL;
        }
        else if ([self.scheme isEqualToString:[DYZRouteConfig routeSchemeExternal]] ||
                 [self.scheme isEqualToString:[DYZRouteConfig routeSchemeClient]]) {
            NSString *newScheme = aURL.host;
            NSString *newPath = aURL.path;
            NSString *newQuery = aURL.query;
            NSString *newURLString = [NSString stringWithFormat:@"%@:/%@?%@", newScheme, newPath, newQuery];
            self.useableURL = [NSURL URLWithString:newURLString];
            
            if ([self.scheme isEqualToString:[DYZRouteConfig routeSchemeClient]]) {
                self.scheme = self.useableURL.scheme;
            }
        }
        else {
            self.scheme = nil;
            self.useableURL = nil;
        }
        self.module = [self.useableURL.host removeUnderscoreAndInitials];
        NSString *path = self.useableURL.path;
        self.page = [[path.length ? path : nil substringFromIndex:1] removeUnderscoreAndInitials];
        self.query = self.useableURL.query;

        NSDictionary *urlDict = [NSDictionary dictionaryWithURLQuery:self.useableURL.query];
        [urlDict setValue:@"2" forKey:URLRouteVersion];
        //兼容下划线首字母大写
        NSMutableDictionary *muteURLDict = [NSMutableDictionary dictionaryWithDictionary:urlDict];
        [urlDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [muteURLDict setObject:obj forKey:[key removeUnderscoreAndInitials]];
        }];
        self.parameter = muteURLDict;
    }
    return self;
}

+ (BOOL)isStandardURL:(NSURL *)url {
    NSString *scheme = url.scheme;
    BOOL isStandard = [ZCMRouteScheme isStandardScheme:scheme];
    if (!isStandard && [scheme isEqualToString:[DYZRouteConfig routeSchemeClient]]) {
        NSString *nScheme = url.host;
        isStandard = [ZCMRouteScheme isStandardScheme:nScheme];
    }
    return isStandard;
}

+ (BOOL)isStandardScheme:(NSString *)scheme {
    return [scheme isEqualToString:[ZCMRouteScheme nativeScheme]] ||
    [scheme isEqualToString:[DYZRouteConfig routeSchemeExternal]] ||
    [scheme isEqualToString:[DYZRouteConfig routeSchemeWeb]] ||
    [scheme isEqualToString:[DYZRouteConfig routeSchemeFile]] ||
    [scheme isEqualToString:[DYZRouteConfig routeSchemeSECWeb]];
}

+ (NSString *)nativeScheme {
    ZCMURLRouteConfig *config = [ZCMURLRouteConfig defaultRouteConfig];
    return [config valueForKey:@"nativeScheme"] ?: [DYZRouteConfig routeSchemeNative];
}

@end
