//
//  DYZOrderInfoCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZOrderInfoCell.h"

@interface DYZOrderInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;
@property (weak, nonatomic) IBOutlet UIView *viewPaying;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end

@implementation DYZOrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnCancel.layer.masksToBounds = YES;
    self.btnCancel.layer.cornerRadius = 2;
    self.btnCancel.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
    self.btnCancel.layer.borderWidth = 0.5;
    self.btnComplete.layer.masksToBounds = YES;
    self.btnComplete.layer.cornerRadius = 2;
    self.btnComplete.layer.borderColor = [UIColor colorWithHexString:@"d1bb8d"].CGColor;
    self.btnComplete.layer.borderWidth = 0.5;
    
    self.btnPay.layer.masksToBounds = YES;
    self.btnPay.layer.cornerRadius = 2;
}


- (void)setModel:(OrderModel *)model {
    _model = model;
    _lblTitle.text = _model.title;
    [_imageV sd_setImageWithURLString:_model.img];
    if ([_model.status isEqualToString:@"0"]) {
        _viewPaying.hidden = NO;
    } else {
        _viewPaying.hidden = YES;
    }
}


- (IBAction)didPressedCancel:(id)sender {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

- (IBAction)didPressedPay:(id)sender {
    if (_payBlock) {
        _payBlock();
    }
}

@end
