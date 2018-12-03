//
//  SignInOperationViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/29.
//  Copyright © 2018 清. All rights reserved.
//

#import "SignInOperationViewController.h"

@interface SignInOperationViewController ()

@end

@implementation SignInOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.signInBackViewBottomValue.constant = -300;
    self.HeadrIamgeView.layer.masksToBounds = YES;
    self.HeadrIamgeView.layer.cornerRadius = self.HeadrIamgeView.bounds.size.height/2;
    self.signInBackView.backgroundColor = [UIColor whiteColor];
    [self.signInButton addTarget:self action:@selector(signInandOutBuutonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.signOutButton addTarget:self action:@selector(signInandOutBuutonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.notToButton addTarget:self action:@selector(signInandOutBuutonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = kColor_RGBA(63, 63, 63, 0.7);
    
    
    
//    [self.signInButton setBackgroundImage:[UIImage imageNamed:@"fqiandao_no"] forState:UIControlStateSelected];
//    [self.signOutButton setBackgroundImage:[UIImage imageNamed:@"fqiantui_no"] forState:UIControlStateSelected];
//    [self.notToButton setBackgroundImage:[UIImage imageNamed:@"fweidao_no"] forState:UIControlStateSelected];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.signInBackViewBottomValue.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
-(void)signInandOutBuutonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(signInOperationWithButtonTag:withSelectRow:)]) {
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.delegate signInOperationWithButtonTag:button.tag withSelectRow:self.selectRow];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches) {
        if (touch.view == self.view) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
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
