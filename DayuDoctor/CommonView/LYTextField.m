//
//  LYTextField.m


#import "LYTextField.h"

@implementation LYTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
    }
    return self;
}


//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x + self.textLeftOffset, bounds.origin.y , bounds.size.width - self.textLeftOffset - self.textRightOffset, bounds.size.height);
    return inset;
}


//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x  +  self.textLeftOffset, bounds.origin.y, bounds.size.width - self.textLeftOffset - self.textRightOffset, bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x  +  self.textLeftOffset, bounds.origin.y, bounds.size.width - self.textLeftOffset - self.textRightOffset, bounds.size.height);
    return inset;
}


@end
