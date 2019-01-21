//
//  DYZResponseNewsList.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYZResponseNews : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@end

@interface DYZResponseNewsData : NSObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<DYZResponseNews *> *content;
@end

@interface DYZResponseNewsList : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) DYZResponseNewsData *data;
@end



NS_ASSUME_NONNULL_END
