//
//  NSObject+Swizzle.h
//  bangjob
//
//  Created by 赵学良 on 2018/4/23.
//  Copyright © 2018年 com.58. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector;

+ (void)swizzleClassSelector:(SEL)orgSelector withNewSelector:(SEL)newSelector;

@end
