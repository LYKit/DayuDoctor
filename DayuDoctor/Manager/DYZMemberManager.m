//
//  DYZMemberManager.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMemberManager.h"
#import "APILogin.h"

NSString * const kLoginSuccesStatus = @"loginSuccesStatus";
NSString * const kOutLoginSuccesStatus = @"outLoginSuccesStatus";

@implementation DYZMemberManager

+ (instancetype)sharedMemberManger {
    static DYZMemberManager *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [DYZMemberManager new];
    });
    return share;
}


+ (void)saveMemberInfo:(NSString *)mobile password:(NSString *)password
{
    if (mobile.length && password.length) {
        [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)clearMemberInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [DYZMemberManager sharedMemberManger].token = @"";
}


+ (LocalMemberInfo)getMemberInfo
{
    NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    return (LocalMemberInfo){mobile?:@"",password?:@""};
}

+ (void)aotuLogin {
    NSString *mobile = [self getMemberInfo].mobile;
    NSString *password = [self getMemberInfo].password;
    if (!mobile.length || !password.length) {
        return;
    }
    APILogin *request = [APILogin new];
    request.mobile = mobile;
    request.userpwd = password;
    [request startPostWithSuccessBlock:^(ResponseLogin *responseObject, NSDictionary *options) {
        if (responseObject.resultcode.integerValue == 0) {
            [DYZMemberManager sharedMemberManger].token = responseObject.token;
        }
        [DYZMemberManager loginSuccess];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

+ (void)loginSuccess {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccesStatus object:nil];
}


+ (void)outLogin {
    [DYZMemberManager clearMemberInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kOutLoginSuccesStatus object:nil];
}


+ (BOOL)isLogin {
    return [DYZMemberManager sharedMemberManger].token.length;
}
@end
