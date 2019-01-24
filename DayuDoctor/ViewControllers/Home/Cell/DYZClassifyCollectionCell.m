//
//  DYZClassifyCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZClassifyCollectionCell.h"


@interface DYZClassifyCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end

@implementation DYZClassifyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 25;
    self.imageView.layer.masksToBounds = YES;
}


- (void)setModel:(ClassifyModel *)model {
    _model = model;
    [_imageView sd_setImageWithURLString:_model.icon];
    _lblName.text = _model.name;
}

@end
