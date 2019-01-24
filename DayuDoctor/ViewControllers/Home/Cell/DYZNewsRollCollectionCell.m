//
//  DYZNewsRollCollectionCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZNewsRollCollectionCell.h"
#import "UIView+YYAdd.h"

@interface DYZNewsRollCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *contentViewRoll;


@property (weak, nonatomic) IBOutlet UILabel *lblCurrent;
@property (weak, nonatomic) IBOutlet UILabel *lblNext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintNextTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCurrentCenter;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;


@end

@implementation DYZNewsRollCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _index = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.constraintNextTop.constant = self.contentView.height/2.0 - _lblCurrent.height/2;
}


- (void)setNewsList:(NSArray *)newsList {
    _newsList = newsList;
    
    [_timer invalidate];
    _timer = nil;
    
    if (_newsList.count) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateNews) userInfo:nil repeats:YES];
        _lblCurrent.text = _newsList.firstObject.title;
    }
}



- (void)updateNews {
    if (_index >= _newsList.count-1) {
        _index = 0;
    } else {
        ++_index;
    }
    
    _lblNext.text = self.newsList[_index].title;
    [UIView animateWithDuration:0.5 animations:^{
        _constraintCurrentCenter.constant = -self.contentView.height/2.0-_lblCurrent.height/2;
        [self.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            _lblCurrent.text = self.newsList[_index].title;
            _constraintCurrentCenter.constant = 0;
        }
    }];
}


- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}




@end
