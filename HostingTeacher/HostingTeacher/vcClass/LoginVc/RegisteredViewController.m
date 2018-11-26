//
//  RegisteredViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.cornerRadius = 5;
    [self.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
-(void)sureButtonClick{
    
    if (self.phoneTextField.text.length != 11) {
        [MyAlerView alterMessage:@"手机号不正确"];
        return;
    }
    if (self.passwordTextField.text.length < 6) {
        [MyAlerView alterMessage:@"密码长度不能小于6位"];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.surePasswordTextField.text]) {
        [MyAlerView alterMessage:@"两次密码输入不一致"];
        return;
    }
    if (self.schoolNameTextField.text.length < 1) {
        [MyAlerView alterMessage:@"学校名称不能为空"];
        return;
    }
    if (self.schoolManagenameTextField.text.length < 1) {
        [MyAlerView alterMessage:@"校长名称不能为空"];
        return;
    }
    if (self.schoolAdressTextField.text.length < 1) {
        [MyAlerView alterMessage:@"学校地址不能为空"];
        return;
    }
    
    [self.view endEditing:YES];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:self.phoneTextField.text forKey:@"Mobile"];
    [params setValue:self.passwordTextField.text forKey:@"Password"];
    [params setValue:self.schoolNameTextField.text forKey:@"GartenName"];
    [params setValue:self.schoolManagenameTextField.text forKey:@"RealName"];
    [params setValue:self.schoolAdressTextField.text forKey:@"Address"];
    
    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_Registration params:params withLoading:YES isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        [LoadDataSuggest showFailWith:dataSource[@"message"]];
        [self.navigationController popViewControllerAnimated:NO];
        
    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        
    }];
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
