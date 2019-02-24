//
//  DYZMainHeaderView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainHeaderView.h"


@interface DYZMainHeaderView ()


@end

@implementation DYZMainHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createBaseView];
}

+ (DYZMainHeaderView *)createFromNib {
    DYZMainHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    return view;
}

- (void)createBaseView {

    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    for (UIView *view in self.searchBar.subviews) {
        for (UIView *subViews in view.subviews) {
            if ([subViews isKindOfClass:[UITextField class]]) {
//                [subViews setRadius:15.0];
                subViews.backgroundColor = [UIColor whiteColor];//输入框背景色
                if (@available(iOS 11.0, *)) {
                    subViews.frame = CGRectMake(0, 7, self.searchBar.frame.size.width, 30);
                    UITextField *textField = (UITextField *)subViews;
                    textField.font = [UIFont systemFontOfSize:14.0f];
                    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
                }
                break;
            }
        }
    }
    
}

@end
