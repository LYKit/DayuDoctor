//
//  UIImageView+DYZWebImageView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "UIImageView+DYZWebImageView.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (DYZWebImageView)

- (void)sd_setImageWithURLString:(nullable NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        [self sd_setImageWithURL:url];
    }
}
@end
