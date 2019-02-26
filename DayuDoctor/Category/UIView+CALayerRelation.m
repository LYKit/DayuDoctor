//
//  UIView+CALayerRelation.m
//  TCTravel_IPhone
//
//  Created by Tracy－jun on 14/11/12.
//
//

#import "UIView+CALayerRelation.h"

@implementation UIView (CALayerRelation)

-(void)beginRespirationLamp{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:self.alpha>0?1:0];
    animation.toValue=[NSNumber numberWithFloat:self.alpha>0?0:1];
    animation.autoreverses=YES;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.duration=2;
    animation.fillMode=kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"RespirationLamp"];
}

-(void)endRespirationLamp{
    [self.layer removeAnimationForKey:@"RespirationLamp"];
}

-(void)setRadius:(float)_radius{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:_radius]; //设置矩圆角半径
}

- (void)addGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)fromColor.CGColor,
                       (id)toColor.CGColor,nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
