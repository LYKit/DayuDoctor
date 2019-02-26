//
//  NSString+SizeWithFont.h
//  TCTCategory
//
//  Created by maxfong on 15/5/7.
//  Copyright (c) 2015年 maxfong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SizeWithFont)

/*
 *  用于计算显示多行文字(兼容7及以下)
 *
 *  @param font          字体
 *  @param size          size
 *  @param lineBreakMode linbreakmode
 *
 *  @return CGSize 返回
 */
- (CGSize)sizeWithFontCustom:(UIFont *)font
           constrainedToSize:(CGSize)size
               lineBreakMode:(int)lineBreakMode;


- (CGSize)sizeWithFontCustom:(UIFont *)font
          constrainedToSize:(CGSize)size;

- (CGSize)sizeWithFontCustom:(UIFont *)font;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
