//
//  NSString+URLEncoded.h
//  ZCMURLRoute
//

#import <Foundation/Foundation.h>

@interface NSString (ZCMURLCode)

/** 字符串是否包含空格 */
- (BOOL)isWhitespace;
/** 字符串是否包含空格或长度要大于0 */
- (BOOL)isEmptyOrWhitespace;

#pragma mark -
/** 对URL的参数编码 */
- (NSString *)URLEncodedString;
/** 对URL的参数解码 */
- (NSString *)URLDecodedString;

@end
