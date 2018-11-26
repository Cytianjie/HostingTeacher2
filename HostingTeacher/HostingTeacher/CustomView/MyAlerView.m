//
//  MyAlerView.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/14.
//  Copyright © 2018 清. All rights reserved.
//

#import "MyAlerView.h"

@implementation MyAlerView

+(void)alterMessage:(NSString *)message{

    UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"提 示" message:message delegate:nil cancelButtonTitle:@"关 闭" otherButtonTitles:nil,nil];
    [alter show];
}
@end
