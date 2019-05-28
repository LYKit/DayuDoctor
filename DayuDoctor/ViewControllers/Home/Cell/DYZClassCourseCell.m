//
//  DYZClassCourseCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZClassCourseCell.h"
#import "DYZMemberManager.h"


@interface DYZClassCourseCell()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *teacherLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *buyNumLabel;
@end

@implementation DYZClassCourseCell

- (void)setClassifyCourse:(ClassifyCourse *)classCourse {
    [_imgView sd_setImageWithURLString:classCourse.img];
    _titleLabel.text = classCourse.title;
    _teacherLabel.text = [NSString stringWithFormat:@"主讲人：%@", classCourse.teacher];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", classCourse.amount];
    _buyNumLabel.text = [NSString stringWithFormat:@"已购买人数 %@", classCourse.buynum];
    
    if ([[DYZMemberManager getMemberInfo].mobile isEqualToString:@"18610592122"]) {
        _priceLabel.hidden = YES;
        _buyNumLabel.hidden = YES;
    } else {
        _priceLabel.hidden = NO;
        _buyNumLabel.hidden = NO;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    _imgView.backgroundColor = [UIColor yellowColor];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_titleLabel];

    __weak typeof(self) _self = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_self.imgView).mas_offset(5);
        make.left.equalTo(_self.imgView.mas_right).mas_offset(10);
        make.right.equalTo(self.contentView).mas_offset(-16);
        make.height.mas_equalTo(15);
    }];
    
    _teacherLabel = [UILabel new];
    _teacherLabel.font = [UIFont systemFontOfSize:13];
    _teacherLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_teacherLabel];
    [_teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).mas_offset(25);
        make.left.right.equalTo(_titleLabel);
        make.height.mas_equalTo(13);
    }];
    
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_self.imgView.mas_bottom);
        make.left.equalTo(_self.titleLabel);
        make.height.mas_equalTo(13);
    }];
    
    
    
    _buyNumLabel = [UILabel new];
    _buyNumLabel.font = [UIFont systemFontOfSize:13];
    _buyNumLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_buyNumLabel];
    [_buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_self.imgView.mas_bottom);
        make.left.equalTo(_self.priceLabel.mas_right).mas_offset(10);
        make.height.mas_equalTo(13);
        make.right.mas_lessThanOrEqualTo(-16);
    }];

    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
    
    return self;
}



@end
