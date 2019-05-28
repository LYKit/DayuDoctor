//
//  DYZCachingCell.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCachingCell.h"


@interface DYZCachingCell()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation DYZCachingCell

- (void)setModel:(HSSessionModel *)model {
    model.progressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        _label.text = [NSString stringWithFormat:@"%lf", progress];
    };
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    UIImageView *testView = [UIImageView new];
    testView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:testView];
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    _label = [UILabel new];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).mas_offset(5);
        make.right.mas_equalTo(-16);
    }];
    
    _statusLabel = [UILabel new];
    _statusLabel.font = [UIFont systemFontOfSize:13];
    _statusLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imgView);
        make.left.right.equalTo(_label);
    }];
    
    
    
    return self;
}
@end
