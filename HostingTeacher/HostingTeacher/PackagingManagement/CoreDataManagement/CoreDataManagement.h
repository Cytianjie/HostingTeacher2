//
//  CoreDataManagement.h
//  FunacademyEducation
//
//  Created by 清 on 2018/11/12.
//  Copyright © 2018 清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManagement : NSObject
//插入数据
+(NSManagedObject *)insertNewObjectForEntityForName:(NSString *)name;
+(void)removeObject:(NSManagedObject *)object;
//读取查询
+(NSManagedObject *)updateDataObjectForEntityForName:(NSString *)name predicate:(NSPredicate *)predicate;
+ (NSArray *)readDataForEntityForName:(NSString *)name;

//保存数据
+ (void)saveContext;
@end

NS_ASSUME_NONNULL_END
