//
//  RegisteredViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisteredViewController : RootTableViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolManagenameTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolAdressTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

NS_ASSUME_NONNULL_END
