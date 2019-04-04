//
//  NSObject+Swizzle.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector;

+ (void)swizzleClassSelector:(SEL)orgSelector withNewSelector:(SEL)newSelector;

@end
