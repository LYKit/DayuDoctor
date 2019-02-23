//
//  DYZMeetDetailCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIOrdersDetail.h"

static NSString * const kDYZMeetDetailCell = @"DYZMeetDetailCell";


@class PUserInfo;
@interface DYZMeetDetailCell : UITableViewCell
@property (nonatomic, strong) PUserInfo *model;

@end


@interface PUserInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL isDoctor;

+ (PUserInfo *)createModel:(NSString *)title value:(NSString *)value;
+ (PUserInfo *)createModel:(NSString *)title value:(NSString *)value isDoctor:(BOOL)isDoctor;
@end


