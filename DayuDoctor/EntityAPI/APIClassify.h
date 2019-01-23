//
//  APIClassify.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestObject.h"
#import "LYResponseObject.h"


NS_ASSUME_NONNULL_BEGIN

@interface APIClassify : LYRequestObject

@end



@interface ClassifyModel : NSObject
@property (nonatomic, copy) NSString *classID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;


@end


@interface ResponseClassify : LYResponseObject

@property (nonatomic, strong) NSMutableArray<ClassifyModel *> *classifies;

@end

NS_ASSUME_NONNULL_END

