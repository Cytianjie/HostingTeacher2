//
//  MyAlerView.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/14.
//  Copyright © 2018 清. All rights reserved.
//

#import "MyAlerView.h"
#import "AppDelegate.h"

@implementation MyAlerView

+(void)alterMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关 闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [[AppDelegate getAppDelegate].window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
