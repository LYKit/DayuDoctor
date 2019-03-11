//
//  APIUploadImg.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/10.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIUploadImg.h"

@implementation APIUploadImg

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/file/user/image");
        self.mimeType = @"image/png";
        self.file = @"file";
    }
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]*1000];
    self.fileName = [NSString stringWithFormat:@"%@.png",timeSp];
    return self;
}



@end



@implementation ResponseUploadImg


@end
