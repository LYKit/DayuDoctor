//
//  LYRequestUpload.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/8.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYRequestUpload : LYRequestObject

@property (nonatomic, strong) UIImage *uploadImage;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *mimeType;

@end

NS_ASSUME_NONNULL_END
