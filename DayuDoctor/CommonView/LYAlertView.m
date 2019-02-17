//
//  LYAlertView.m
//  bangjob
//
//  Created by 赵学良 on 2018/7/10.
//  Copyright © 2018年 com.58. All rights reserved.
//
//

#import "LYAlertView.h"
#import <objc/runtime.h>

#define LYApplicationKey @"LYAlertView_Water"

@interface LYAlertView ()
<
UIAlertViewDelegate
>

@property(nonatomic,strong)UIAlertView *alert;

@property(nonatomic,copy) void (^sureBlock)();
@property(nonatomic,copy) void (^cancleBlock)();


@end

@implementation LYAlertView



#pragma mark - function

+(void)showAerltViewWithTitle:(NSString *)title
                      message:(NSString *)message
           cancelButtonTtitle:(NSString *)cancelTitle
            ensuerButtonTitle:(NSString *)ensureButtonTitle
             onSureUsingBlock:(void (^)())completeUsingBlock
           onCancelUsingBlock:(void (^)())cancelUsingBlock
{
    //用单例持有Alertview
//    UIApplication *application=[UIApplication sharedApplication];
    id application = [UIApplication sharedApplication].delegate;
    
    //dismiss上次的弹框
    LYAlertView *lastAlert=objc_getAssociatedObject(application, LYApplicationKey);
    [lastAlert.alert dismissWithClickedButtonIndex:lastAlert.alert.cancelButtonIndex animated:NO];
    objc_setAssociatedObject(application, LYApplicationKey, nil, OBJC_ASSOCIATION_ASSIGN);
    
    LYAlertView *temp=[[LYAlertView alloc] init];
    temp.sureBlock   = completeUsingBlock;
    temp.cancleBlock = cancelUsingBlock;
    temp.alert=[[UIAlertView alloc] initWithTitle:title
                                          message:message
                                         delegate:temp
                                cancelButtonTitle:cancelTitle
                                otherButtonTitles:ensureButtonTitle, nil];
    [temp.alert show];
    
    objc_setAssociatedObject(application, LYApplicationKey, temp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(BOOL)bHadAlert
{
    id application = [UIApplication sharedApplication].delegate;;
    LYAlertView *lastAlert=objc_getAssociatedObject(application, LYApplicationKey);
    return (lastAlert != nil);
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.cancelButtonIndex) {
        if (self.cancleBlock) {
            self.cancleBlock();
            self.cancleBlock = nil;
        }
    }else{
        if (self.sureBlock) {
            self.sureBlock();
            self.sureBlock = nil;
        }
    }
    alertView.delegate = nil;
    
    //移除
    //    UIApplication *application=[UIApplication sharedApplication];
    id application = [UIApplication sharedApplication].delegate;;
    
    objc_setAssociatedObject(application, LYApplicationKey, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end
