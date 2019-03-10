//
//  APIMessage.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"


@interface APIMessage : DYZRequestObject
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;


@end


@interface Message : NSObject
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *url;


@end

@interface ResponseMessage : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<Message *> *list;

@end


