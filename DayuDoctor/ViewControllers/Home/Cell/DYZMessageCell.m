//
//  DYZMessageCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMessageCell.h"


@interface DYZMessageCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation DYZMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
}


- (void)setModel:(Message *)model {
    _model = model;
    _lblTitle.text = _model.title;
    _lblContent.text = _model.createTime;
}

@end
