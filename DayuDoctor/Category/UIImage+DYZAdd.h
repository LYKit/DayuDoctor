//
//  UIImage+DYZAdd.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/8.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DYZAdd)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithHexColor:(NSString *)hexColor;

@end

NS_ASSUME_NONNULL_END
