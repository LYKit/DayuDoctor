//
//  DYZRequestObject.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/7.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYZRequestObject : LYRequestObject

@property (nonatomic, strong) UIView *noResultView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
