//
//  DYZCacheListBottomView.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/26.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZCacheListBottomView.h"

@implementation DYZCacheListBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_selectedButton setTitle:@"全选" forState:UIControlStateNormal];
    [_selectedButton setTitle:@"取消全选" forState:UIControlStateSelected];
    [self addSubview:_selectedButton];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(_selectedButton.mas_right);
        make.width.mas_equalTo(kScreenWidth / 2);
    }];
    

    
    
    return self;
}

@end
