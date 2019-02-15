//
//  DYZMineCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/23.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZMineCell.h"

@implementation DYZMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    _label = [UILabel new];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
//    self.bottomLine.hidden = YES;
    
    return self;
}


@end
