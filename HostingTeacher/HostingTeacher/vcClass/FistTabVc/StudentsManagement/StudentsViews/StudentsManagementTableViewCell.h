//
//  StudentsManagementTableViewCell.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/27.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentsManagementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingValue;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end

NS_ASSUME_NONNULL_END
