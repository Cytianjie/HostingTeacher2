//
//  SchoolBulletinViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/12/4.
//  Copyright © 2018 清. All rights reserved.
//

#import "SchoolBulletinViewController.h"
#import "SchoolBulletinListTableViewCell.h"

@interface SchoolBulletinViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SchoolBulletinViewController

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
    
    SchoolBulletinListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleNameLabel.text = @"你的身边的煎熬不到";
    cell.timeLabel.text = @"2014-01-01";
    cell.contentLabel.text = @"回宿舍接口和时间肯定会受到客户开始打快点等级考试的肯定可是大家看得见啊空间大克拉的骄傲了空间大克拉的骄傲了的";
    return cell;
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
