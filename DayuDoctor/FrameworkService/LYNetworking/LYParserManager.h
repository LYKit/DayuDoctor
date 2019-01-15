//
//  LYParserManager.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/8/10.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYParserManager : NSObject

+ (id)objectParserJsonMapPropertyWithClassString:(NSString *)clsStr
                                    responseName:(NSString *)responseName
                                            data:(NSDictionary *)data;


+ (id)dataSourcePath:(NSString *)path
         classString:(NSString *)clsStr
        responseName:(NSString *)responseName;




@end
