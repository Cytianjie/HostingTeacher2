//
//  AttendanceManagementViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/28.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceManagementViewController : RootViewController
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
