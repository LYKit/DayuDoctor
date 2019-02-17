//
//  DYZMineCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/23.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZMineCell.h"

@interface DYZMineCell ()
@property (nonatomic, strong) UILabel *label;

@end

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
    
    UIImageView *arrow = [[UIImageView alloc] init];
    arrow.image = [UIImage imageNamed:@"icon_tc_rightarrow"];
    [self.contentView addSubview:arrow];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(8);
    }];
    // icon_tc_rightarrow
    
    return self;
}


- (void)setStrTitle:(NSString *)strTitle {
    _strTitle = strTitle;
    _label.text = _strTitle;
}


@end
