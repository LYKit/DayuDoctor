//
//  DYZMemberManager.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kLoginSuccesStatus;
extern NSString * const kOutLoginSuccesStatus;


typedef struct {
    NSString *mobile;
    NSString *password;
} LocalMemberInfo;

@interface DYZMemberManager : NSObject

+ (instancetype)sharedMemberManger;

@property (nonatomic, copy) NSString *token;

// 存储账号密码到本地
+ (void)saveMemberInfo:(NSString *)mobile password:(NSString *)password;
+ (void)clearMemberInfo;

// 获取本地账号密码
+ (LocalMemberInfo)getMemberInfo;

+ (void)aotuLogin;

+ (void)loginSuccess;

+ (void)outLogin;

+ (BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
