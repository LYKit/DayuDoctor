//
//  ZCMRouteScheme.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@interface ZCMRouteScheme : NSObject

@property (nonatomic, strong, readonly) NSURL *originalURL;
@property (nonatomic, strong, readonly) NSURL *useableURL;
@property (nonatomic, strong, readonly) NSString *query;
@property (nonatomic, strong, readonly) NSString *scheme;           //规则
@property (nonatomic, strong, readonly) NSString *module;           //模块
@property (nonatomic, strong, readonly) NSString *page;             //页面
@property (nonatomic, strong, readonly) NSDictionary *parameter;    //参数

- (instancetype)initWithURL:(NSURL *)URL;

+ (BOOL)isStandardURL:(NSURL *)url;

+ (NSString *)nativeScheme;

@end
