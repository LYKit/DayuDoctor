//
//  DYZRouteConfig.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/4/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRouteConfig.h"

@implementation DYZRouteConfig

//跳转native页面
+ (NSString *)routeSchemeNative {
    return @"dyzy";
}

//跳转外部
+ (NSString *)routeSchemeExternal {
    return @"external";
}

//跳转web
+ (NSString *)routeSchemeWeb {
    return @"http";
}

//跳转安全web
+ (NSString *)routeSchemeSECWeb {
    return @"https";
}

//文件
+ (NSString *)routeSchemeFile {
    return @"file";
}

//外部/浏览器启动客户端
+ (NSString *)routeSchemeClient {
    return @"dyzy";
}

//plist 规则前缀
+ (NSString *)routePrefix {
    return @"Dyzy";
}

@end
