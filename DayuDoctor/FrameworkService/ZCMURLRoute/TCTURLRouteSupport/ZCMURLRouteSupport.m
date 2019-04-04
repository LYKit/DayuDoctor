//
//  ZCMURLRouteSupport.m
//  ZCMURLRoute
//


#import "ZCMURLRouteSupport.h"
#import "ZCMURLRouteConfig.h"
#import "DYZRouteConfig.h"


@implementation ZCMURLRouteSupport

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"PLISTSALLLOADED"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
            NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:resourcePath];
            for (NSString *fileName in enumerator) {
                if ([fileName hasPrefix:[DYZRouteConfig routePrefix]] && [fileName hasSuffix:@"URLRoute.plist"]) {
                    NSString *plistPath = [NSString stringWithFormat:@"%@/%@", resourcePath, fileName];
                    [ZCMURLRouteConfig addRouteWithPlistPath:plistPath];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PLISTSALLLOADED" object:nil];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"PLISTSALLLOADED"];
            });
        });
        
#ifdef DEBUG
        [[ZCMURLRouteConfig routeDictionary] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:[DYZRouteConfig routeSchemeNative]]) {
                [obj enumerateKeysAndObjectsUsingBlock:^(NSString *key1, NSDictionary *obj1, BOOL * _Nonnull stop) {
                    [obj1 enumerateKeysAndObjectsUsingBlock:^(NSString * key2, NSDictionary * obj2, BOOL * _Nonnull stop) {
                        if ([obj2 isKindOfClass:[NSDictionary class]]) {
                            NSString *classString = obj2[@"_class"];
                            if (classString.length) {
                                Class cls = NSClassFromString(classString);
                                if (!cls) {
                                    NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRouteConfig:%@类名不存在，请检查", classString]);
                                }
                            }
                            NSDictionary *hold = obj2[@"_hold"];
                            classString = hold[@"_class"];
                            if (classString.length) {
                                Class cls = NSClassFromString(classString);
                                if (!cls) {
                                    NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRouteConfig:%@类名不存在，请检查", classString]);
                                }
                            }
                        }
                    }];
                }];
            }
        }];
#endif
    });
}

@end
