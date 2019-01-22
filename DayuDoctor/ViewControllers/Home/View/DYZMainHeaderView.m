//
//  DYZMainHeaderView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainHeaderView.h"


@interface DYZMainHeaderView ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;

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
    
}

@end
