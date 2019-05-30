//
//  DYZMyCollectionCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZMyCollectionCell.h"

@interface DYZMyCollectionCell()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *courseNameLabel;
@property (nonatomic, strong) UILabel *teacLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIImageView *selectImgView;
@end

@implementation DYZMyCollectionCell


- (void)setCollectionCourse:(CollectionCourse *)course {
    [_imgView sd_setImageWithURLString:course.img];
    _courseNameLabel.text = course.title;
    _teacLabel.text = [NSString stringWithFormat:@"主讲人：%@", course.teacher];
    _priceLabel.text = course.amount;
    _amountLabel.text = [NSString stringWithFormat:@"已购买人数：%@", course.buynum];
    if (course.isSelected) {
        _selectImgView.highlighted = YES;
    } else {
        _selectImgView.highlighted = NO;
    }
    
    if (   [[DYZMemberManager getMemberInfo].mobile isEqualToString:@"18610592122"]
        || ![DYZMemberManager isLogin]) {
        _priceLabel.hidden = YES;
        _amountLabel.hidden = YES;
    } else {
        _priceLabel.hidden = NO;
        _amountLabel.hidden = NO;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
//    UIImage *unselectImg = [UIImage imageNamed:@"unselect"];
//    UIImage *selected = [UIImage imageNamed:@"selected"];
//    _selectImgView = [UIImageView new];
//    _selectImgView.image = unselectImg;
//    _selectImgView.highlightedImage = selected;
//    [self.contentView addSubview:_selectImgView];
//    [_selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(-32);
//        make.centerY.equalTo(self.contentView);
//        make.size.mas_equalTo(_selectImgView.image.size);
//    }];
    
    
    
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _courseNameLabel = [UILabel new];
    _courseNameLabel.font = [UIFont systemFontOfSize:15];
    _courseNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_courseNameLabel];
    [_courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(15);
    }];
    
    
    _teacLabel = [UILabel new];
    _teacLabel.font = [UIFont systemFontOfSize:13];
    _teacLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_teacLabel];
    [_teacLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_courseNameLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(_courseNameLabel);
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(-16);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_teacLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(_teacLabel);
        make.height.mas_equalTo(13);
    }];
    
    _amountLabel = [UILabel new];
    _amountLabel.font = [UIFont systemFontOfSize:13];
    _amountLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel);
        make.left.equalTo(_priceLabel.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-16);
        make.height.mas_equalTo(13);
    }];
    return self;
}
@end
