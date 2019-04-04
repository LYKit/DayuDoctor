//
//  ZCMURLBridge.m
//  ZCMURLRoute
//

#import "ZCMURLBridge.h"
#import "NSString+URLCode.h"
#import "ZCMRouteScheme.h"

@implementation ZCMURLBridge

+ (NSURL *)routeURLFromString:(NSString *)aString {
    if (!aString.length) return nil;
    
    NSURL *oldURL = [NSURL URLWithString:aString];
    if (oldURL) {
#if DEBUG
        NSLog(@"URLRoute检测通过");
        NSLog(@"URLRoute链接不需要转换");
#endif
        return oldURL;
    }

    return nil;
}

+ (NSURL *)routeURLWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter {
    NSMutableString *paramString = [NSMutableString string];
    
    NSString *param = @"";
    if (parameter.allValues) {
        [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [paramString appendFormat:@"%@=%@&", key, obj];
        }];
        param = [paramString substringToIndex:(paramString.length-1)];    //去掉最后一位&
    }
    
    NSString *URLString = [NSString stringWithFormat:@"%@://%@/%@?%@", [ZCMRouteScheme nativeScheme], module, page, param];
    return [NSURL URLWithString:URLString];
}


@end
