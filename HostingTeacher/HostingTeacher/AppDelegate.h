//
//  AppDelegate.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/21.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+(AppDelegate *)getAppDelegate;

@end

