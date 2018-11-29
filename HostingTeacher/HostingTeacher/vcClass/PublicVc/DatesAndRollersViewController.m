//
//  DatesAndRollersViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/23.
//  Copyright © 2018 清. All rights reserved.
//

#import "DatesAndRollersViewController.h"

@interface DatesAndRollersViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,copy) DataRollersSuccess  dataRollersSuccess;
@property(nonatomic,strong) NSArray * dataArray;
@property(nonatomic,assign) NSInteger  type;
@property(nonatomic,strong) UIView * backView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *pickerView;
@end

@implementation DatesAndRollersViewController

+(instancetype)initWithStyle:(NSInteger)type withArray:(NSArray *)dataArray withFromVc:(UIViewController *)fromVc withDataRollersSuccess:(DataRollersSuccess)dataRollersSuccess{
    DatesAndRollersViewController * vc = [[DatesAndRollersViewController alloc]init];
    vc.dataRollersSuccess = dataRollersSuccess;
    vc.dataArray = dataArray;
    vc.type = type;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dispatch_async(dispatch_get_main_queue(), ^{
        [fromVc presentViewController:vc animated:NO completion:nil];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor_RGBA(63, 63, 63, 0.7);
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 280 + Height_BottomSafetyZone)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    
    UIButton * canleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    canleButton.frame = CGRectMake(0, 0, 60, 45);
    [canleButton setTitle:@"取消" forState:UIControlStateNormal];
    [canleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [canleButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:canleButton];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(kScreen_Width - 60, 0, 60, 45);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:kColor_RGBA(0, 215, 255, 1) forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:sureButton];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.backView addSubview:lineView];
    
    if (self.type == 1) {
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.frame = CGRectMake(0, 46, kScreen_Width, self.backView.bounds.size.height - Height_BottomSafetyZone - 46);
        //设置地区: zh-中国
        self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [self.datePicker setDate:[NSDate date] animated:YES];
        [self.backView addSubview:self.datePicker];
    
    }else if (self.type == 2) {
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 46, kScreen_Width, self.backView.bounds.size.height - Height_BottomSafetyZone - 46)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.backView addSubview:self.pickerView];
        [self.pickerView reloadAllComponents];
    }
    
    
    
}
-(void)cancelButtonClick{
    [self dismissViewControllerAnimated:NO completion:^{
        [UIView animateWithDuration:0.2 animations:^{
            self.backView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 280 + Height_BottomSafetyZone);
        }];
    }];
}
-(void)sureButtonButtonClick{
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.type == 1) {
            self.dataRollersSuccess([TJToolsClass dateChangeToStringformat:self.datePicker.date withFormatter:@"yyyy-MM-dd"]);
        }else if (self.type == 2){
            self.dataRollersSuccess([NSString stringWithFormat:@"%ld",(long)[self.pickerView selectedRowInComponent:0]]);
        }
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelButtonClick];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, kScreen_Height - self.backView.frame.size.height, kScreen_Width, 280 + Height_BottomSafetyZone);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.dataArray objectAtIndex:row];
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
@end
