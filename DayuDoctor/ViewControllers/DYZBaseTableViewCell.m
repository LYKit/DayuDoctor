//
//  DYZBaseTableViewCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZBaseTableViewCell.h"

@implementation DYZBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.mas_equalTo(16);
        make.right.equalTo(self.contentView).mas_offset(-16);
        make.height.mas_equalTo(0.5);
    }];
    _bottomLine = line;
    return self;
}

@end
