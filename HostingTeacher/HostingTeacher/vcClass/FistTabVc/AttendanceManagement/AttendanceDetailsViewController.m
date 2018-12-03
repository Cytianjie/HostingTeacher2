//
//  AttendanceDetailsViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/29.
//  Copyright © 2018 清. All rights reserved.
//

#import "AttendanceDetailsViewController.h"
#import "PublicFistTableViewController.h"
#import "SignInOperationViewController.h"

@interface AttendanceDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,SignInOperationDelegate>
@property(nonatomic,strong) UIBarButtonItem * editlBarButtonItem;
@property(nonatomic,strong) UIBarButtonItem * editlCanaleBarButtonItem;
@property(nonatomic,strong) UIBarButtonItem * editlDownBarButtonItem;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)NSMutableDictionary * editDic;
@end

@implementation AttendanceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isEdit = NO;
    self.editDic = [[NSMutableDictionary alloc]init];
    [self.segmented addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    UIButton * editlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editlButton.frame = CGRectMake(0, 0, 88, 44);
    editlButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [editlButton setTitle:@"批量操作" forState:UIControlStateNormal];
    [editlButton setTitleColor:kColor_RGBA(21, 126, 251, 1) forState:UIControlStateNormal];
    [editlButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.editlBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:editlButton];
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, 0, 44, 44);
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.editlCanaleBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleButton];
    
    
    UIButton * downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame = CGRectMake(0, 0, 44, 44);
    downButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [downButton setTitle:@"完成" forState:UIControlStateNormal];
    [downButton setTitleColor:kColor_RGBA(21, 126, 251, 1) forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.editlDownBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:downButton];
    
    self.navigationItem.rightBarButtonItems = @[self.editlBarButtonItem];
    
}
-(void)segmentedChange:(UISegmentedControl *)segmented{
    [self.tableView reloadData];
}
-(void)editButtonClick{
    self.isEdit = YES;
    [self.editDic removeAllObjects];
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItems = @[self.editlCanaleBarButtonItem,self.editlDownBarButtonItem];
}
-(void)cancleButtonClick{
    self.isEdit = NO;
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItems = @[self.editlBarButtonItem];
}
-(void)downButtonClick{
    self.isEdit = NO;
    self.navigationItem.rightBarButtonItems = @[self.editlBarButtonItem];
    
    for (NSString * key in self.editDic) {
        if ([[self.editDic objectForKey:key] isEqualToString:@"1"]) {
            NSLog(@"---->>> %@",key);
        }
    }
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
    [cell.phoneButton setImage:nil forState:UIControlStateNormal];
    [cell.phoneButton setBackgroundImage:nil forState:UIControlStateNormal];
    cell.phoneButtonWidthValue.constant = 60;
    if (self.segmented.selectedSegmentIndex == 0) {
        [cell.phoneButton setTitle:@"签到" forState:UIControlStateNormal];
        [cell.phoneButton setTitleColor:kColor_RGBA(21, 126, 251, 1) forState:UIControlStateNormal];
    }else if (self.segmented.selectedSegmentIndex == 1) {
        [cell.phoneButton setTitle:@"签退" forState:UIControlStateNormal];
        [cell.phoneButton setTitleColor:kColor_RGBA(214, 148, 44, 1) forState:UIControlStateNormal];
    }else{
        [cell.phoneButton setTitle:@"未到" forState:UIControlStateNormal];
        [cell.phoneButton setTitleColor:kColor_RGBA(255, 0, 0, 1) forState:UIControlStateNormal];
    }
    
    if (self.isEdit == YES) {
        cell.headerImageViewLeftValue.constant = 8;
    }else{
        cell.headerImageViewLeftValue.constant = -25;
    }
    
    if (self.isEdit == YES) {
        cell.selectImageView.image = [UIImage imageNamed:@"selectcellimage_no"];
        if ([[self.editDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
            NSString * valueString = [self.editDic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            if ([valueString isEqualToString:@"1"]) {
               cell.selectImageView.image = [UIImage imageNamed:@"selectcellimage"];
            }
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEdit == YES) {
        if ([[self.editDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
            NSString * valueString = [self.editDic valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            if ([valueString isEqualToString:@"1"]) {
                [self.editDic setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            }else{
                [self.editDic setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            }
        }else{
            [self.editDic setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        [self.tableView reloadData];
        
    }else{
        SignInOperationViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInOperationViewController"];
        vc.selectRow = indexPath.row;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc.delegate = self;
        [self presentViewController:vc animated:NO completion:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    }
    
}
//签到，签退
-(void)signInOperationWithButtonTag:(NSInteger)buttonTag withSelectRow:(NSInteger)row{
    if (buttonTag == 0) {
        //签到，签到撤回
    }else if (buttonTag == 1){
        //签退，签退撤回
    }else if (buttonTag == 2){
        //未到
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"未到原因" message:nil preferredStyle: UIAlertControllerStyleAlert];
        [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入未到原因";
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ok, %@", [[alertVc textFields] objectAtIndex:0].text);
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:action2];
        [alertVc addAction:action1];
        [self presentViewController:alertVc animated:YES completion:nil];
        
        
    }
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
