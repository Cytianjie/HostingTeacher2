//
//  SelectTeachrsViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol SelectTeachrsDelegate <NSObject>

-(void)selectTeachrDic:(NSDictionary *)dicModel row:(NSInteger)row type:(NSInteger)type;

@end

@interface SelectTeachrsViewController : RootViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,weak)id<SelectTeachrsDelegate> delegate;
//l预留字段
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
