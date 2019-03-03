//
//  DYZVersionContentCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZVersionContentCell.h"

@interface DYZVersionContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end


@implementation DYZVersionContentCell



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setStrContent:(NSString *)strContent {
    _strContent = strContent;
    _lblContent.text = _strContent;
}

@end
