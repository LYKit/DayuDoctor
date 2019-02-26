//
//  DYZSearchListCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZSearchListCell.h"


@interface DYZSearchListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

@end

@implementation DYZSearchListCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setModel:(SearchModel *)model {
    _model = model;
    [_picture sd_setImageWithURLString:_model.img];
    _lblTitle.text = _model.title;
    _lblName.text = [NSString stringWithFormat:@"主讲人：%@",_model.teacher];
    _lblMoney.text = _model.amount;
    _lblCount.text = [NSString stringWithFormat:@"已购买人数%@",_model.buynum];
}


@end
