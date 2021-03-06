//
//  DYZCoursesTableCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCoursesTableCell.h"

@interface DYZCoursesTableCell()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation DYZCoursesTableCell

- (void)setCourse:(Course *)course {
    [_imgView setImageWithURL:[NSURL URLWithString:course.img] placeholder:nil];
    _titleLabel.text = course.title;
    
    if (   [[DYZMemberManager getMemberInfo].mobile isEqualToString:@"18610592122"]
        || ![DYZMemberManager isLogin]) {
        _descLabel.text = [NSString stringWithFormat:@"主讲人：%@", course.teacher];
        _descLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    } else {
        
        if ([course.buynum isEqualToString:@"1"]) {
            _descLabel.text = @"已经购买";
        } else {
            _descLabel.text = @"未购买";
        }
        _descLabel.textColor = [UIColor redColor];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_titleLabel];
    
    __weak typeof(self) _self = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_self.imgView).mas_offset(10);
        make.left.equalTo(_self.imgView.mas_right).mas_offset(10);
        make.right.equalTo(self.contentView).mas_offset(-16);
        make.height.mas_equalTo(15);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_self.imgView.mas_bottom).mas_offset(-10);
        make.left.right.equalTo(_self.titleLabel);
        make.height.mas_equalTo(13);
    }];
    return self;
}
@end
