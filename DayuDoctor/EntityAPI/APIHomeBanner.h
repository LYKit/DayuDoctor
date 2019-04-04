//
//  APIHomeBanner.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"


@interface APIHomeBanner : DYZRequestObject
@property (nonatomic, copy) NSString *type; // 0课程，1资讯，2面授，3答疑，4加盟，5医馆



@end


@interface BannerModel : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger bannerIndex;
@property (nonatomic, copy) NSString *jumpUrl;

@end

@interface ResponseHomeBanner : LYResponseObject
@property (nonatomic, strong) NSMutableArray<BannerModel *> *banners;


@end
