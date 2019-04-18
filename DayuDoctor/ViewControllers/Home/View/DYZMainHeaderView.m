//
//  DYZMainHeaderView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainHeaderView.h"
#import "UIView+CALayerRelation.h"


@interface DYZMainHeaderView () 
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constranitOfHeight;

@end

@implementation DYZMainHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewSearch.layer.masksToBounds = YES;
    self.viewSearch.layer.cornerRadius = 17;
    self.constranitOfHeight.constant = IS_IPHONE_X ? 88 : 64;
}

+ (DYZMainHeaderView *)createFromNib {
    DYZMainHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    return view;
}




- (IBAction)didPressedSearch:(id)sender {
    if ([self.delegate respondsToSelector:@selector(searchBarDidClick)]) {
        [self.delegate searchBarDidClick];
    }
}


- (IBAction)didPressedMessage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageDidClick)]) {
        [self.delegate messageDidClick];
    }
}

- (IBAction)didPressedDownload:(id)sender {
    if ([self.delegate respondsToSelector:@selector(downloadDidClick)]) {
        [self.delegate downloadDidClick];
    }
}

@end
