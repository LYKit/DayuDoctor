//
//  DYZMainHeaderView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainHeaderView.h"
#import "UIView+CALayerRelation.h"


@interface DYZMainHeaderView () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

@end

@implementation DYZMainHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createBaseView];
    self.searchBar.delegate = self;
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
                [subViews setRadius:20.0];
                subViews.backgroundColor = [UIColor whiteColor];//输入框背景色
                if (@available(iOS 11.0, *)) {
                    subViews.frame = CGRectMake(0, 7, self.searchBar.frame.size.width, 40);
                    UITextField *textField = (UITextField *)subViews;
                    textField.font = [UIFont systemFontOfSize:14.0f];
                    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
                }
                break;
            }
        }
    }
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if ([self.delegate respondsToSelector:@selector(searchBarDidClick)]) {
        [self.delegate searchBarDidClick];
    }
    return NO;
}

@end
