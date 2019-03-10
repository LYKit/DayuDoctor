//
//  APIUploadImg.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/10.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestUpload.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIUploadImg : LYRequestUpload
@property (nonatomic, strong) NSData *file;

@end

NS_ASSUME_NONNULL_END
