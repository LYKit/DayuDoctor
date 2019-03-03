//
//  DYZMessageCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIMessage.h"


NS_ASSUME_NONNULL_BEGIN

static NSString * const kDYZMessageCell = @"DYZMessageCell";


@interface DYZMessageCell : UITableViewCell

@property (nonatomic, strong) Message *model;


@end


NS_ASSUME_NONNULL_END
