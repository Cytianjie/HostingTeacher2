//
//  DatesAndRollersViewController.h
//  HostingTeacher
//
//  Created by 清 on 2018/11/23.
//  Copyright © 2018 清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void (^DataRollersSuccess)(NSString * string);

@interface DatesAndRollersViewController : UIViewController
//type 1,日期，，，2，滚轮
+(instancetype)initWithStyle:(NSInteger)type withArray:(NSArray *)dataArray withFromVc:(UIViewController *)fromVc withDataRollersSuccess:(DataRollersSuccess)dataRollersSuccess;
@end

NS_ASSUME_NONNULL_END
