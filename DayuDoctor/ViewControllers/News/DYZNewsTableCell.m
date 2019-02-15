//
//  DYZNewsTableCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZNewsTableCell.h"
#import <Masonry.h>
#import <YYKit.h>

@interface DYZNewsTableCell()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation DYZNewsTableCell

- (void)setNews:(News *)news {
    [_imgView setImageWithURL:[NSURL URLWithString:news.img] placeholder:nil];
    _titleLabel.text = news.title;
    _descLabel.text = news.time;
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
    _descLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_self.imgView.mas_bottom).mas_offset(-10);
        make.left.right.equalTo(_self.titleLabel);
        make.height.mas_equalTo(13);
    }];
    return self;
}

@end
