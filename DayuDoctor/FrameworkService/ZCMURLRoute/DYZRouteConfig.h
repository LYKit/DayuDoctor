//
//  DYZRouteConfig.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/4/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface DYZRouteConfig : NSObject

+ (NSString *)routeSchemeNative;    //默认跳转native页面
+ (NSString *)routeSchemeExternal;  //跳转外部
+ (NSString *)routeSchemeWeb;       //跳转web
+ (NSString *)routeSchemeSECWeb;    //跳转安全web
+ (NSString *)routeSchemeFile;      //
+ (NSString *)routeSchemeClient;    //外部/浏览器启动客户端

+ (NSString *)routePrefix;          //plist 规则前缀

@end

NS_ASSUME_NONNULL_END
