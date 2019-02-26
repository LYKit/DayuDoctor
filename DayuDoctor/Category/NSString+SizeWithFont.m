//
//  NSString+SizeWithFont.m
//  TCTCategory
//
//  Created by maxfong on 15/5/7.
//  Copyright (c) 2015年 maxfong. All rights reserved.
//

#import "NSString+SizeWithFont.h"

@implementation NSString (SizeWithFont)

- (CGSize)sizeWithFontCustom:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(int)lineBreakMode
{
    return [self sizeWithFontCustom:font constrainedToSize:size];
}


- (CGSize)sizeWithFontCustom:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect frame = [self boundingRectWithSize:size
                                      options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary context:nil];
    return CGSizeMake(round(frame.size.width+0.5), round(frame.size.height+0.5));
}


- (CGSize)sizeWithFontCustom:(UIFont *)font
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize frame = [self sizeWithAttributes:attributesDictionary];
    return CGSizeMake(round(frame.width+0.5), round(frame.height+0.5));
}


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

@end
