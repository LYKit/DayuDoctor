//
//  DYZQACell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/20.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZQACell.h"

@interface DYZQACell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lblQ;
@property (weak, nonatomic) IBOutlet UILabel *lblA;

@end


@implementation DYZQACell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"aaaaaa"].CGColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 4;
}


- (void)setModel:(FAQSModel *)model {
    _model = model;
    _lblQ.text = [NSString stringWithFormat:@"Q：%@",_model.question];
    _lblA.text = [NSString stringWithFormat:@"a：%@",_model.answer];
}

@end
