//
//  AddStudentsViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/27.
//  Copyright © 2018 清. All rights reserved.
//

#import "RootTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddStudentsViewController : RootTableViewController
@property (weak, nonatomic) IBOutlet UIButton *headerImageButton;
@property (weak, nonatomic) IBOutlet UITextField *studentNameField;
@property (weak, nonatomic) IBOutlet UITextField *parentNameField;
@property (weak, nonatomic) IBOutlet UITextField *parentPhoneField;
@property (weak, nonatomic) IBOutlet UILabel *outGradeLabel;
@property (weak, nonatomic) IBOutlet UIView *selectServiceView;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;

//其他信息
@property (weak, nonatomic) IBOutlet UISwitch *isParkSwitch;
@property (weak, nonatomic) IBOutlet UILabel *inGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bornTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *admissionDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *familyAdressField;
@property (weak, nonatomic) IBOutlet UITextField *secondPhoneField;
@property (weak, nonatomic) IBOutlet UIButton *deleButton;



@property(nonatomic,strong)NSDictionary * incomingDataDic;
@end

NS_ASSUME_NONNULL_END
