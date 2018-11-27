//
//  AddTeachersTableViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/23.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTeachersTableViewController : RootTableViewController
@property (weak, nonatomic) IBOutlet UIButton *headerImageButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UILabel *bornTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inductionTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleButton;

@property(nonatomic,strong)NSDictionary * incomingDataDic;

@end

NS_ASSUME_NONNULL_END
