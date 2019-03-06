//
//  DYZOrderInfoCell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIOrderList.h"


NS_ASSUME_NONNULL_BEGIN

static NSString * const kDYZOrderInfoCell = @"DYZOrderInfoCell";

@interface DYZOrderInfoCell : UITableViewCell
@property (nonatomic, strong) OrderModel *model;

@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property (nonatomic, copy) dispatch_block_t payBlock;

@end

NS_ASSUME_NONNULL_END
