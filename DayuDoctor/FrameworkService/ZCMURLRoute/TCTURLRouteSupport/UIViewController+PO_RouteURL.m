//
//  UIViewController+PO_RouteURL.m
//  ZCMURLRoute
//


#import "UIViewController+PO_RouteURL.h"
#import "NSObject+Swizzle.h"

static BOOL bALLPlistsLoaded = NO;
static id po_observer = nil;

@implementation UIViewController (PO_RouteURL)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL openRouteURL = @selector(openRouteURL:options:);
        SEL po_openRouteURL = @selector(po_openRouteURL:options:);
        [self swizzleInstanceSelector:openRouteURL withNewSelector:po_openRouteURL];
    });
}


// plist规则 都加载完后再执行
- (void)po_openRouteURL:(NSURL *)url options:(NSDictionary *)options {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PLISTSALLLOADED"] isEqualToString:@"1"]) {
        [self po_openRouteURL:url options:options];
    } else {
        if (bALLPlistsLoaded) {
            [self po_openRouteURL:url options:options];
        } else {
            if (po_observer) {
                [[NSNotificationCenter defaultCenter] removeObserver:po_observer];
            }
            po_observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"PLISTSALLLOADED" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                bALLPlistsLoaded = YES;
                [self po_openRouteURL:url options:options];
                [[NSNotificationCenter defaultCenter] removeObserver:po_observer];
                po_observer = nil;
            }];
        }
    }
}

@end
