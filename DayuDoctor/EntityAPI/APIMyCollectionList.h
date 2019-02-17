//
//  APIMyCollectionList.h
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"


@interface APIMyCollectionList : LYRequestObject

@end

@interface  CollectionCourse : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *buynum;
@end

@interface ResponseMyCollection : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<CollectionCourse *> *content;

@end


