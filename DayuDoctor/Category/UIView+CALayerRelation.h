//
//  UIView+CALayerRelation.h
//  TCTravel_IPhone
//
//  Created by Tracy－jun on 14/11/12.
//
//

#import <UIKit/UIKit.h>

@interface UIView (CALayerRelation)

/**
 *  呼吸灯效果
 */
- (void)beginRespirationLamp;
- (void)endRespirationLamp;

/**
 *  设置圆角
 *
 *  @param _radius 半径
 */
-(void)setRadius:(float)_radius;

/**
 *  增加渐变色
 * 
 *  @param fromColor 从哪种Color
 *  @param toColor   到哪种Color
 */
- (void)addGradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
