//
//  TeachersManagementTableViewCell.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import "TeachersManagementTableViewCell.h"

@implementation TeachersManagementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = self.headerImageView.bounds.size.height/2;
    self.headerImageView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
