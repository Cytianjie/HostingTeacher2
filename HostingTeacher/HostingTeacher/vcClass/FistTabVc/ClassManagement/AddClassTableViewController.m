//
//  AddClassTableViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "AddClassTableViewController.h"
#import "SelectTeachrsViewController.h"

@interface AddClassTableViewController ()<SelectTeachrsDelegate>
@property(nonatomic,strong)NSMutableDictionary * paramsDic;
@end

@implementation AddClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.paramsDic = [[NSMutableDictionary alloc]init];
    
    if (self.incomingDataDic != nil) {
        self.delButton.hidden = NO;
        self.title = @"班级详情";
        
        self.classNameLabel.text = self.incomingDataDic[@"ClassName"];
        self.zhujiaoLabel.text = self.incomingDataDic[@"BishopTeacherName"];
        self.fujiao1Label.text = self.incomingDataDic[@"AssistantFirstName"];
        self.fujiao2Label.text = self.incomingDataDic[@"AssistantSecondName"];
        //选择部分
        [self.paramsDic setValue:[self.incomingDataDic[@"ID"] description] forKey:@"ID"];
        [self.paramsDic setValue:self.paramsDic[@"BishopTeacher"] forKey:@"BishopTeacher"];
        [self.paramsDic setValue:self.paramsDic[@"AssistantFirst"] forKey:@"AssistantFirst"];
        [self.paramsDic setValue:self.paramsDic[@"AssistantFirst"] forKey:@"AssistantSecond"];
    }else{
        self.delButton.hidden = YES;
        [self.paramsDic setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"GartenID"];
        [self.paramsDic setValue:@"" forKey:@"AssistantFirst"];
        [self.paramsDic setValue:@"" forKey:@"AssistantSecond"];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
        SelectTeachrsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectTeachrsViewController"];
        vc.delegate = self;
        vc.row = indexPath.row;
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)selectTeachrDic:(NSDictionary *)dicModel row:(NSInteger)row type:(NSInteger)type{
    NSDictionary * modelDic = dicModel[@"usermodel"];
    if (row == 1) {
        self.zhujiaoLabel.text = modelDic[@"RealName"];
        [self.paramsDic setValue:[modelDic[@"Uid"] description] forKey:@"BishopTeacher"];
    }else if (row == 2) {
        self.fujiao1Label.text = modelDic[@"RealName"];
        [self.paramsDic setValue:[modelDic[@"Uid"] description] forKey:@"AssistantFirst"];
    }else if (row == 3) {
        
        self.fujiao2Label.text = modelDic[@"RealName"];
        [self.paramsDic setValue:[modelDic[@"Uid"] description] forKey:@"AssistantSecond"];
    }
}
- (IBAction)saveAction:(id)sender {
    
    [self.view endEditing:YES];
    if (self.classNameLabel.text.length < 1) {
        [MyAlerView alterMessage:@"班级名称不能为空"];
        return;
    }
    if (self.zhujiaoLabel.text.length < 1) {
        [MyAlerView alterMessage:@"主教老师不能为空"];
        return;
    }
    [self.paramsDic setValue:self.classNameLabel.text forKey:@"ClassName"];
    
    NSString * url = URL_ClassAdd;
    
    if (self.incomingDataDic != nil) {
        url = URL_ClassEdit;
    }

    [[NetworkRequestManager manager]POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:url params:self.paramsDic imageArry:nil withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        [LoadDataSuggest showFailWith:dataSource[@"message"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {

    }];

}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (IBAction)delButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        [params setValue:[self.incomingDataDic[@"ID"] description] forKey:@"ID"];
        [[NetworkRequestManager manager] POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:URL_ClassDel params:params imageArry:nil withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
            [LoadDataSuggest showFailWith:dataSource[@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
            
        }];
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
