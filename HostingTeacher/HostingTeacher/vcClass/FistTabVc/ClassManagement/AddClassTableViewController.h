//
//  AddClassTableViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddClassTableViewController : RootTableViewController
@property (weak, nonatomic) IBOutlet UITextField *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhujiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fujiao1Label;
@property (weak, nonatomic) IBOutlet UILabel *fujiao2Label;
@property (weak, nonatomic) IBOutlet UIButton *delButton;

@end

NS_ASSUME_NONNULL_END
