//
//  DYZQACell.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/20.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIFAQS.h"

static NSString * const kDYZQACell = @"DYZQACell";


@interface DYZQACell : UITableViewCell

@property (nonatomic, strong) FAQSModel *model;


@end

