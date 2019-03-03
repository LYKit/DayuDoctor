//
//  APIVersion.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIVersion.h"

@implementation APIVersion

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/app/update/ios");
    }
    return self;
}

@end


@implementation VersionInfo

- (NSString *)url {
    if (!_url) {
        _url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?";
    }
    return _url;
}


@end


@implementation ResponseVersion

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"detail" : [VersionInfo class],
             };
}

@end
