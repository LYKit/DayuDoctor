//
//  APIHomeBanner.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"


@interface APIHomeBanner : LYRequestObject



@end


@interface BannerModel : NSObject
@property (nonatomic, copy) NSString *url;

@end

@interface ResponseHomeBanner : LYResponseObject
@property (nonatomic, strong) NSMutableArray<BannerModel *> *banners;


@end
