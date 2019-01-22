//
//  APINewsList.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"

@interface APINewsList : LYRequestObject

@end





@interface News : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *time;
@end

@interface ResponseNewsList : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<News *> *content;
@end

