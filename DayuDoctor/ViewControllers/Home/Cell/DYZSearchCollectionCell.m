//
//  DYZSearchCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZSearchCollectionCell.h"
#import "NSString+SizeWithFont.h"

@interface DYZSearchCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end


@implementation DYZSearchCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 18;
}


- (void)setStrTitle:(NSString *)strTitle {
    _strTitle = strTitle;
    _lblTitle.text = _strTitle;
}

+ (CGSize)cellSize:(NSString *)title {
    CGFloat width = [title sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(CGFLOAT_MAX, 20) mode:NSLineBreakByCharWrapping].width;
    width = width > 280 ? 280 : width;
    width = width < 20 ? 20 : width;
    return CGSizeMake(width+20, 36);
}

@end
