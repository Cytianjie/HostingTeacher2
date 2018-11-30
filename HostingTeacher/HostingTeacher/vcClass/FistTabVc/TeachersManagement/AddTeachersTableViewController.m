//
//  AddTeachersTableViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/23.
//  Copyright © 2018 清. All rights reserved.
//

#import "AddTeachersTableViewController.h"
#import "DatesAndRollersViewController.h"

@interface AddTeachersTableViewController ()
@property(nonatomic,strong)NSMutableDictionary * paramsDic;
@property(nonatomic,strong)NSMutableArray * headerImageArray;
@end

@implementation AddTeachersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.paramsDic = [[NSMutableDictionary alloc]init];
    self.headerImageArray = [[NSMutableArray alloc]init];
    self.headerImageButton.layer.cornerRadius = self.headerImageButton.bounds.size.height/2;
    self.headerImageButton.layer.masksToBounds = YES;
    [self.headerImageButton addTarget:self action:@selector(headerImageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.deleButton addTarget:self action:@selector(deleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.incomingDataDic != nil) {
        self.deleButton.hidden = NO;
        self.title = @"教师详情";
        NSDictionary * modelDic = self.incomingDataDic[@"usermodel"];
        [self.headerImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPHEADER_URL,modelDic[@"Avatar"]]]  forState:UIControlStateNormal placeholderImage:[TJToolsClass getHeaderPlaceholderImage]];
        self.nameField.text = modelDic[@"RealName"];
        self.phoneField.text = modelDic[@"Mobile"];
        self.sexLabel.text = modelDic[@"Sex"];
        self.positionLabel.text = [self.incomingDataDic[@"rolename"] description];
        self.nickNameField.text = modelDic[@"NickName"];
        self.emailField.text = modelDic[@"Email"];
        self.recordLabel.text = modelDic[@"Education"];;
        self.bornTimeLabel.text = modelDic[@"BirthDate"];;
        self.inductionTimeLabel.text = modelDic[@"EntryDate"];;
        
        //选择部分
        [self.paramsDic setValue:[modelDic[@"Uid"] description] forKey:@"Uid"];
        [self.paramsDic setValue:[modelDic[@"Sex"] description] forKey:@"Sex"];
        [self.paramsDic setValue:[modelDic[@"RoleID"] description] forKey:@"RoleID"];
        [self.paramsDic setValue:[modelDic[@"Education"] description] forKey:@"Education"];
        [self.paramsDic setValue:[modelDic[@"BirthDate"] description] forKey:@"BirthDate"];
        [self.paramsDic setValue:[modelDic[@"EntryDate"] description] forKey:@"EntryDate"];
    }else{
        self.deleButton.hidden = YES;
        [self.paramsDic setValue:@"" forKey:@"Education"];
        [self.paramsDic setValue:@"" forKey:@"BirthDate"];
        [self.paramsDic setValue:@"" forKey:@"EntryDate"];
        [self.paramsDic setValue:[MyLogInUserManager manager].userData.htRoleID forKey:@"RoleID"];
        [self.paramsDic setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"GartenId"];
        [self.headerImageButton setBackgroundImage:[TJToolsClass getHeaderPlaceholderImage] forState:UIControlStateNormal];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    
    if (indexPath.row == 3) {
        NSArray * conArray = @[@"男",@"女"];
        [DatesAndRollersViewController initWithStyle:2 withArray:conArray withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
            self.sexLabel.text = conArray[string.intValue];
            [self.paramsDic setValue:self.sexLabel.text forKey:@"Sex"];
        }];
    }else if (indexPath.row == 4) {
        
        [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_Rolelist params:[NSMutableDictionary dictionary] withLoading:YES isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
            NSArray * dataSourceArray = dataSource[@"data"];
            if ([dataSourceArray isKindOfClass:[NSArray class]]) {
                NSMutableArray * conArray = [[NSMutableArray alloc]init];
                for (NSDictionary * dic in dataSourceArray) {
                    [conArray addObject:[dic[@"Name"] description]];
                }
                    [DatesAndRollersViewController initWithStyle:2 withArray:conArray withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
                        self.positionLabel.text = conArray[string.intValue];
                        NSDictionary * postDic = dataSourceArray[string.intValue];
                         [self.paramsDic setValue:[postDic[@"ID"] description] forKey:@"RoleID"];
                    }];
            }
            
        } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
            
        }];
        
    }else if (indexPath.row == 8) {
        NSArray * conArray = @[@"初中",@"高中",@"专科",@"本科",@"研究生",@"其他"];
        [DatesAndRollersViewController initWithStyle:2 withArray:conArray withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
            self.recordLabel.text = conArray[string.intValue];
            [self.paramsDic setValue:self.recordLabel.text forKey:@"Education"];
        }];
    }else if (indexPath.row == 9) {
        [DatesAndRollersViewController initWithStyle:1 withArray:@[] withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
            self.bornTimeLabel.text = string;
            [self.paramsDic setValue:string forKey:@"BirthDate"];
        }];
    }else if (indexPath.row == 10) {
        [DatesAndRollersViewController initWithStyle:1 withArray:@[] withFromVc:self withDataRollersSuccess:^(NSString * _Nonnull string) {
            self.inductionTimeLabel.text = string;
            [self.paramsDic setValue:string forKey:@"EntryDate"];
        }];
    }
    
    
}

-(void)headerImageButtonClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"提示" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关 闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相 册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍 照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerController:UIImagePickerControllerSourceTypeCamera];
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
}
//选中de图片
-(void)getPicturesSuccessful:(UIImage *)image{
    [self.headerImageButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.headerImageArray removeAllObjects];
    [self.headerImageArray addObject:image];
}

- (IBAction)saveAction:(id)sender {

    [self.view endEditing:YES];
    
    if (self.nameField.text.length < 1) {
        [MyAlerView alterMessage:@"姓名不能为空"];
        return;
    }
    if (self.phoneField.text.length < 1) {
        [MyAlerView alterMessage:@"手机号不能为空"];
        return;
    }
    if (self.sexLabel.text.length < 1) {
        [MyAlerView alterMessage:@"性别不能为空"];
        return;
    }
    if (self.positionLabel.text.length < 1) {
        [MyAlerView alterMessage:@"职务不能为空"];
        return;
    }
    [self.paramsDic setValue:self.nameField.text forKey:@"RealName"];
    [self.paramsDic setValue:self.phoneField.text forKey:@"Mobile"];
    
    //其他
    [self.paramsDic setValue:self.nickNameField.text forKey:@"NickName"];
    [self.paramsDic setValue:self.emailField.text forKey:@"Email"];
    

    NSString * url = URL_GartenStaffAdd;
    
    if (self.incomingDataDic != nil) {
        if (self.headerImageArray.count > 0) {
            [self.paramsDic setValue:@"" forKey:@"Avatar"];
        }else{
            NSDictionary * modelDic = self.incomingDataDic[@"usermodel"];
            [self.paramsDic setValue:[modelDic[@"Avatar"] description] forKey:@"Avatar"];
        }
        
        url = URL_GartenStaffEdit;
    }
    [[NetworkRequestManager manager] POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:url params:self.paramsDic imageArry:self.headerImageArray withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        [LoadDataSuggest showFailWith:dataSource[@"message"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {

    }];
    
 
}
-(void)deleButtonClick{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
        NSDictionary * modelDic = self.incomingDataDic[@"usermodel"];
        [params setValue:[modelDic[@"Uid"] description] forKey:@"id"];
        [[NetworkRequestManager manager] POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:URL_GartenStaffDel params:params imageArry:nil withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
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
