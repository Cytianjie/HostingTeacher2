//
//  LoginViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "RegisteredViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logInButton.layer.cornerRadius = self.logInButton.bounds.size.height/2;
    self.creatSchoolButton.layer.cornerRadius = self.logInButton.bounds.size.height/2;;
    [self.creatSchoolButton.layer setBorderColor:kColor_RGBA(0, 215, 255, 1).CGColor];
    [self.creatSchoolButton.layer setBorderWidth:1];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)logInAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    if (self.phoneTextField.text.length < 1 || self.passwordTextField.text.length < 1) {
        [MyAlerView alterMessage:@"手机号或密码不能为空"];
        return;
    }
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:self.phoneTextField.text forKey:@"Mobile"];
    [params setValue:self.passwordTextField.text forKey:@"Password"];
    
    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_MobileLogon params:params withLoading:YES isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        NSDictionary * dataSourceDic = dataSource;
        NSDictionary * dataDic = dataSourceDic[@"data"];
        NSString * uid = [dataDic[@"Uid"] description];
        [[MyLogInUserManager manager] login:uid];
        
        
        DBUserData * userDataModel = [MyLogInUserManager manager].userData;
        userDataModel.htAvatar = [dataDic[@"Avatar"] description];
        userDataModel.htComeFrom = [dataDic[@"ComeFrom"] description];
        userDataModel.htCreatorTime = [dataDic[@"CreatorTime"] description];
        userDataModel.htEmail = [dataDic[@"Email"] description];
        userDataModel.htFinish = [dataDic[@"Finish"] description];
        userDataModel.htGartenId = [dataDic[@"GartenId"] description];
        userDataModel.htLastLoginTime = [dataDic[@"LastLoginTime"] description];
        userDataModel.htMobile = [dataDic[@"Mobile"] description];
        userDataModel.htNickName = [dataDic[@"NickName"] description];
        userDataModel.htPassword = [dataDic[@"Password"] description];
        userDataModel.htRealName = [dataDic[@"RealName"] description];
        userDataModel.htRoleID = [dataDic[@"RoleID"] description];
        userDataModel.htSortCode = [dataDic[@"SortCode"] description];
        userDataModel.htStatus = [dataDic[@"Status"] description];
        userDataModel.htUid = uid;
        userDataModel.htUserType = [dataDic[@"UserType"] description];
        userDataModel.htUser_IP = [dataDic[@"User_IP"] description];
        
        [CoreDataManagement saveContext];
         
        
        MainTabBarViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
        [self presentViewController:vc animated:NO completion:nil];
        
    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        
    }];
    
}
- (IBAction)creatSchoolAction:(id)sender {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    RegisteredViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisteredViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
