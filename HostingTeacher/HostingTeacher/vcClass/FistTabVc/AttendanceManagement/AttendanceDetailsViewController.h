//
//  AttendanceDetailsViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/29.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceDetailsViewController : RootViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
