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

@implementation DYZNewsTableCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_descLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_imageView).mas_offset(10);
        make.left.equalTo(self->_imageView.mas_right).mas_offset(10);
        make.right.equalTo(self.contentView).mas_offset(-16);
        make.height.mas_equalTo(15);
    }];
    
    
    return self;
}

@end
