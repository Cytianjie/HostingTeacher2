//
//  MainLogInViewController.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "MainLogInViewController.h"
#import "MainTabBarViewController.h"
#import "LoginViewController.h"

@interface MainLogInViewController ()

@end

@implementation MainLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[MyLogInUserManager manager] isLogIn]) {
        MainTabBarViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
        [self presentViewController:vc animated:NO completion:nil];
    }else{
        LoginViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:vc animated:NO];
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
