//
//  MyLogInUserManager.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyLogInUserManager : NSObject
+(MyLogInUserManager *)manager;
@property(nonatomic,strong)DBUserData * userData;
-(BOOL)isLogIn;
-(void)login:(NSString *)logintoken;
-(void)logout;
@end

NS_ASSUME_NONNULL_END
