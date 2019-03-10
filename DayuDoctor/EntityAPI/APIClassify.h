//
//  APIClassify.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "LYResponseObject.h"


NS_ASSUME_NONNULL_BEGIN

@interface APIClassify : DYZRequestObject

@end



@interface ClassifyModel : NSObject
@property (nonatomic, copy) NSString *classID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *url;

@end


@interface ResponseClassify : LYResponseObject

@property (nonatomic, strong) NSMutableArray<ClassifyModel *> *classifies;

@end

NS_ASSUME_NONNULL_END

