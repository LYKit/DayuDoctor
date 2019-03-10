//
//  UIImageView+DYZWebImageView.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DYZWebImageView)

- (void)sd_setImageWithURLString:(nullable NSString *)urlString;

- (void)sd_setImageWithURLString:(nullable NSString *)urlString completed:(nullable SDExternalCompletionBlock)completedBlock;
@end

NS_ASSUME_NONNULL_END
