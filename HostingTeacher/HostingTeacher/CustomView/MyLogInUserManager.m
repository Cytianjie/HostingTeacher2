//
//  MyLogInUserManager.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import "MyLogInUserManager.h"

@interface MyLogInUserManager ()
@property(nonatomic,copy)NSString * logintoken;
@end

@implementation MyLogInUserManager
+(MyLogInUserManager *)manager{
    static MyLogInUserManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyLogInUserManager alloc]init];
    });
    return manager;
}

-(DBUserData *)userData{
    
    _userData = (DBUserData *)[CoreDataManagement updateDataObjectForEntityForName:@"DBUserData" predicate:[NSPredicate predicateWithFormat:@"logintoken=%@",self.logintoken]];
    if (_userData == nil) {
        _userData = (DBUserData *)[CoreDataManagement insertNewObjectForEntityForName:@"DBUserData"];
        _userData.logintoken = self.logintoken;
        [CoreDataManagement saveContext];
        
    }
    return _userData;
}

-(BOOL)isLogIn{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"logintoken"]) {
        self.logintoken = [defaults objectForKey:@"logintoken"];
        return YES;
    }
    return NO;
}
-(void)login:(NSString *)logintoken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:logintoken forKey:@"logintoken"];
    self.logintoken = logintoken;
    [defaults synchronize];
}
-(void)logout{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"logintoken"];
    [defaults synchronize];
}
@end
