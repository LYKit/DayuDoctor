//
//  DYZMainHeaderView.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol DYZMainHeaderViewDelegate <NSObject>

- (void)searchBarDidClick;
- (void)messageDidClick;
- (void)downloadDidClick;


@end

@interface DYZMainHeaderView : UIView

+ (DYZMainHeaderView *)createFromNib;

@property (nonatomic, weak) id<DYZMainHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
