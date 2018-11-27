//
//  StudentsManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "StudentsManagementViewController.h"
#import "PublicFistTableViewController.h"
#import "StudentsManagementTableViewCell.h"

@interface StudentsManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign) BOOL isListTypeClass;//列表是否是班级形式
@property(nonatomic,assign) NSInteger selectSection;

@end

@implementation StudentsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isListTypeClass) {
        if (section == self.selectSection) {
            return 10;
        }
        return 0;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StudentsManagementTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    if (self.isListTypeClass) {
        cell.titleLabelLeadingValue.constant = 8;
        cell.leftImageView.hidden = NO;
        cell.sunLabel.hidden = NO;
        cell.tapButton.tag = section;
        [cell.tapButton addTarget:self action:@selector(sectionTapButton:) forControlEvents:UIControlEventTouchUpInside];
        if (section == self.selectSection) {
            cell.leftImageView.image = [UIImage imageNamed:@"yxiajiantou"];
        }else{
            cell.leftImageView.image = [UIImage imageNamed:@"yyoujiantou"];
        }
    }else{
        cell.titleLabelLeadingValue.constant = -8;
        cell.leftImageView.hidden = YES;
        cell.sunLabel.hidden = YES;
    }
    cell.titleLabel.text = @"2222";
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PublicFistTableViewController * publicTableViewVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
    TeachersManagementTableViewCell *cell = [publicTableViewVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLabel.text = @"111";
    cell.subLabel.text = @"222";
    [cell.phoneButton addTarget:self action:@selector(phoneButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
    cell.phoneButton.tag = indexPath.row;
    return cell;
}
-(void)phoneButtonClcik:(UIButton *)button{
//    NSDictionary * dataDic = self.dataArray[button.tag];
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dataDic[@"Mobile"]];
//    UIWebView * callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
}

-(void)sectionTapButton:(UIButton *)button{
    self.selectSection = button.tag;
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)listTypeAction:(id)sender {
    self.isListTypeClass = !self.isListTypeClass;
    [self.tableView reloadData];
}

@end
