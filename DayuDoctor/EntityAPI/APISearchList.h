//
//  APISearchList.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"

@interface APISearchList : DYZRequestObject

@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *keywords;

@end


@interface SearchModel : NSObject
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *buynum;
@property (nonatomic, copy) NSString *url;

@end


@interface ResponseSearchList : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<SearchModel *> *content;

@end
