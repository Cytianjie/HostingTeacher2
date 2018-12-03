//
//  SignInOperationViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/29.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SignInOperationDelegate <NSObject>

//签到，签退
-(void)signInOperationWithButtonTag:(NSInteger)buttonTag withSelectRow:(NSInteger)row;

@end

@interface SignInOperationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *signInBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signInBackViewBottomValue;

@property (weak, nonatomic) IBOutlet UIImageView *HeadrIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UILabel *signOutLabel;
@property (weak, nonatomic) IBOutlet UIButton *notToButton;
@property (weak, nonatomic) IBOutlet UILabel *time1Label;
@property (weak, nonatomic) IBOutlet UILabel *time2Label;

@property (nonatomic, weak) id<SignInOperationDelegate> delegate;
@property(nonatomic,strong)NSDictionary * incomingDataDic;
@property(nonatomic,assign)NSInteger selectRow;


@end

NS_ASSUME_NONNULL_END
