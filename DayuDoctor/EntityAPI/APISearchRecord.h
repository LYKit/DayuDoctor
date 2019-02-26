//
//  APISearchRecord.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"


@interface APISearchRecord : LYRequestObject

@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;


@end




@interface ResponseSearchRecord : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray *record;

@end
