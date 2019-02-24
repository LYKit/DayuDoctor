//
//  DYZMeetDetailCell.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMeetDetailCell.h"

@interface DYZMeetDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation DYZMeetDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(PUserInfo *)model {
    _model = model;
    _lblTitle.text = _model.title;
    _lblContent.text = _model.value;
    if (_model.isDoctor) {
        _lblTitle.textColor = [UIColor blackColor];
        _lblContent.textColor = [UIColor blackColor];
    } else {
        _lblTitle.textColor = [UIColor grayColor];
        _lblContent.textColor = [UIColor grayColor];
    }
}

@end




@implementation PUserInfo
+ (PUserInfo *)createModel:(NSString *)title value:(NSString *)value isDoctor:(BOOL)isDoctor {
    PUserInfo *model = [PUserInfo new];
    model.title = title;
    model.value = value;
    model.isDoctor = isDoctor;
    return model;
}
+ (PUserInfo *)createModel:(NSString *)title value:(NSString *)value {
    return [self createModel:title value:value isDoctor:NO];
}
@end
