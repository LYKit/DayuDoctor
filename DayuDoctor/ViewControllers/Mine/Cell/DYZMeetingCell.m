//
//  DYZMeetingCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMeetingCell.h"

@interface DYZMeetingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;

@end


@implementation DYZMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnStatus.layer.maskedCorners = YES;
    self.btnStatus.layer.cornerRadius = 3;
    self.btnStatus.layer.borderWidth = 0.5;
}

- (void)setModel:(Reservations *)model {
    _model = model;
    if ([model.status isEqualToString:@"0"]) {
        _btnStatus.layer.borderColor = [UIColor grayColor].CGColor;
        [_btnStatus setTitle:@"取消预约" forState:UIControlStateNormal];
        [_btnStatus setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnStatus.enabled = YES;
    } else if ([model.status isEqualToString:@"1"]) {
        _btnStatus.layer.borderColor = [UIColor colorWithHexString:@"cfb789"].CGColor;
        [_btnStatus setTitle:@"已完成" forState:UIControlStateNormal];
        [_btnStatus setTitleColor:[UIColor colorWithHexString:@"cfb789"] forState:UIControlStateNormal];
        _btnStatus.enabled = NO;
    } else if ([model.status isEqualToString:@"-1"]) {
        _btnStatus.layer.borderColor = [UIColor grayColor].CGColor;
        [_btnStatus setTitle:@"已取消" forState:UIControlStateNormal];
        [_btnStatus setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnStatus.enabled = NO;
    }
    
    _lblName.text = _model.doctorName;
    _lblTime.text = [NSString stringWithFormat:@"预约时间：%@",_model.orderDate];
    [_imgPhoto sd_setImageWithURLString:_model.img];
}


- (IBAction)didPressedStatus:(id)sender {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

@end
