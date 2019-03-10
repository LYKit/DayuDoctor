//
//  APIVersion.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"


NS_ASSUME_NONNULL_BEGIN

@interface APIVersion : DYZRequestObject
@property (nonatomic, copy) NSString *version;


@end


@interface VersionInfo : NSObject
@property (nonatomic, copy) NSString *canShowUpdate;
@property (nonatomic, copy) NSString *needUpdate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *url;


@end


@interface ResponseVersion : LYResponseObject
@property (nonatomic, strong) VersionInfo *detail;

@end

NS_ASSUME_NONNULL_END
