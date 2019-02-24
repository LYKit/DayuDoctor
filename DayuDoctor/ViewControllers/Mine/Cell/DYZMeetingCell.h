//
//  DYZMeetingCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIReservations.h"

static NSString * const kDYZMeetingCell = @"DYZMeetingCell";

@interface DYZMeetingCell : UITableViewCell

@property (nonatomic, strong) Reservations *model;

@property (nonatomic, copy) dispatch_block_t cancelBlock;


@end

