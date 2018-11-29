//
//  AttendanceManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/28.
//  Copyright © 2018 清. All rights reserved.
//

#import "AttendanceManagementViewController.h"
#import "DatesAndRollersViewController.h"
#import "PublicFistTableViewController.h"
#import "AttendanceDetailsViewController.h"

@interface AttendanceManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AttendanceManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleButton setImage:[UIImage imageNamed:@"ffangxiajiantou"] forState:UIControlStateNormal];
    self.titleButton.titleLabel.numberOfLines = 2;
    [self.titleButton setTitle:@"午托\n18:00--19:00" forState:UIControlStateNormal];
    self.titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    CGFloat imageWidth = self.titleButton.imageView.bounds.size.width;
    CGFloat labelWidth = [TJToolsClass getWidthWithText:self.titleButton.currentTitle height:44 font:self.titleButton.titleLabel.font];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
}
-(void)titleButtonClick{
    NSArray * conArray = @[@"午托12:00--14:00",@"晚托12:00--14:00"];
    [DatesAndRollersViewController initWithStyle:2 withArray:conArray withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicFistTableViewController * publicTableViewVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
    TeachersManagementTableViewCell *cell = [publicTableViewVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    cell.headerImageView.image = [UIImage imageNamed:@"fbanji"];
    cell.nameLabel.text = @"11";
    cell.subLabel.text = @"共100  签到10  未签10  签退10";
    cell.phoneButton.hidden = YES;
    cell.headerImageView.layer.cornerRadius = 5;
    cell.rightIconImageView.hidden = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AttendanceDetailsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceDetailsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
