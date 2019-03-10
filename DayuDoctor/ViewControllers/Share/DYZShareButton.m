//
//  DYZShareButton.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/26.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZShareButton.h"

@implementation DYZShareButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).mas_offset(10);
        make.centerX.equalTo(self);
    }];
    
    
    return self;
}
@end
