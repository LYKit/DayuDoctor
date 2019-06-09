//
//  DYZClassCourseDetailCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/8.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZClassCourseDetailCell.h"

@interface DYZClassCourseDetailCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation DYZClassCourseDetailCell


- (void)setCourseItem:(CourseItem *)item {
    _nameLabel.text = item.name;
    if ([item.play isEqualToString:@"true"]) {
        _statusLabel.text = @"播放";
    } else {
        _statusLabel.text = @"未知";
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFFAFA"];
    
    
    _statusLabel = [UILabel new];
    _statusLabel.font = [UIFont systemFontOfSize:13];
    _statusLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-16);
    }];
    
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_equalTo(16);
        make.right.lessThanOrEqualTo(_statusLabel.mas_left).mas_offset(10);
    }];
    return self;
}
@end
