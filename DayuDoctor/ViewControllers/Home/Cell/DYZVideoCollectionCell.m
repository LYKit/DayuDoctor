//
//  DYZVideoCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZVideoCollectionCell.h"

@interface DYZVideoCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lblName;


@end

@implementation DYZVideoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(CourseModel *)model {
    _model = model;
    [_imageView sd_setImageWithURLString:_model.img];
    _lblName.text = _model.title;
}

@end
