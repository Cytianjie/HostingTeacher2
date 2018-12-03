//
//  TeachersManagementTableViewCell.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeachersManagementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewLeftValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneButtonWidthValue;

@end

NS_ASSUME_NONNULL_END
