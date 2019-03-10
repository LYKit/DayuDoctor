//
//  APIFAQS.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/20.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"

@interface APIFAQS : DYZRequestObject
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) NSInteger pageSize;

@end


@interface FAQSModel : NSObject
@property (nonatomic, copy) NSString *qid;
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;


@end


@interface ResponseFAQS : LYResponseObject
@property (nonatomic, copy) NSString *total;
@property (nonatomic, strong) NSArray<FAQSModel *> *list;


@end

