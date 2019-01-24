//
//  DYZHeadImageCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHeadImageCollectionCell.h"

@interface DYZHeadImageCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@end

@implementation DYZHeadImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImage.image = [UIImage imageNamed:@"homeHeader"];
}

@end
