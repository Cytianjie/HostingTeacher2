//
//  AttendanceDetailsViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/29.
//  Copyright © 2018 清. All rights reserved.
//

#import "AttendanceDetailsViewController.h"
#import "PublicFistTableViewController.h"

@interface AttendanceDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AttendanceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    cell.headerImageView.image = [TJToolsClass getHeaderPlaceholderImage];
    cell.nameLabel.text = @"章泽天";
    cell.subLabel.text = @"老师";
    cell.headerImageView.layer.cornerRadius = 5;
    [cell.phoneButton setImage:[UIImage imageNamed:@"fqian"] forState:UIControlStateNormal];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
