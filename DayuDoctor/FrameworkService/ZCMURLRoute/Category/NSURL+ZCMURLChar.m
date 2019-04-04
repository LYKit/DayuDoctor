//
//  NSURL+ZCMURLChar.m
//  ZCMURLRoute
//

#import "NSURL+ZCMURLChar.h"
#import "ZCMRouteScheme.h"


@implementation NSURL (ZCMURLChar)

#pragma mark -

- (BOOL)isRouteScheme {
    NSString *scheme = [ZCMRouteScheme nativeScheme];
    return [[self.scheme lowercaseString] isEqualToString:scheme];
}

@end
