//
//  DYZHomeViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHomeViewController.h"

typedef enum : NSUInteger {
    enumHeaderImageSection,
    enumNewsRollSection,
    enumClassifySection,
    enumVideoRecommendSection
} enumSectionType;

@interface DYZHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;


@end

@implementation DYZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

        
}



/// MARK: tableView'delegate


@end
