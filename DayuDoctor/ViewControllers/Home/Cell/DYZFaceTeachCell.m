//
//  DYZFaceTeachCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZFaceTeachCell.h"

@interface DYZFaceTeachCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@end


@implementation DYZFaceTeachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FaceTeachModel *)model {
    _model = model;
    _lblTitle.text = _model.title;
    _lblSubTitle.text = _model.time;
    [_photo sd_setImageWithURLString:_model.img];
}

@end
