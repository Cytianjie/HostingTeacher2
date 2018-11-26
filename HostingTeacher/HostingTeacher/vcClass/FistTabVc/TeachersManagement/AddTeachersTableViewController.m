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
    
    if (self.teacherDataDic != nil) {
        self.deleButton.hidden = NO;
        self.title = @"教师详情";
        [self.headerImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.teacherDataDic[@"Avatar"]]]  forState:UIControlStateNormal placeholderImage:[TJToolsClass getHeaderPlaceholderImage]];
        self.nameField.text = self.teacherDataDic[@"RealName"];
        self.phoneField.text = self.teacherDataDic[@"Mobile"];
        self.sexLabel.text = self.teacherDataDic[@"Sex"];
        self.positionLabel.text = [self.teacherDataDic[@"RoleID"] description];
        self.nickNameField.text = self.teacherDataDic[@"NickName"];
        self.emailField.text = self.teacherDataDic[@"Email"];
        self.recordLabel.text = @"少";
        self.bornTimeLabel.text = @"少";
        self.inductionTimeLabel.text = @"少";
    }else{
        self.deleButton.hidden = YES;
        [self.paramsDic setValue:@"" forKey:@"Education"];
        [self.paramsDic setValue:@"" forKey:@"BirthDate"];
        [self.paramsDic setValue:@"" forKey:@"EntryDate"];
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
        }];
        [self.paramsDic setValue:self.sexLabel.text forKey:@"Education"];
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
//    if (self.phoneField.text.length < 1) {
//        [MyAlerView alterMessage:@"手机号不能为空"];
//        return;
//    }
//    if (self.sexLabel.text.length < 1) {
//        [MyAlerView alterMessage:@"性别不能为空"];
//        return;
//    }
//    if (self.positionLabel.text.length < 1) {
//        [MyAlerView alterMessage:@"职务不能为空"];
//        return;
//    }
    [self.paramsDic setValue:self.nameField.text forKey:@"RealName"];
    [self.paramsDic setValue:self.phoneField.text forKey:@"Mobile"];
    
    //其他
    [self.paramsDic setValue:self.nickNameField.text forKey:@"NickName"];
    [self.paramsDic setValue:self.emailField.text forKey:@"Email"];

//    [[NetworkRequestManager manager] POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:URL_GartenStaffAdd params:self.paramsDic imageArry:self.headerImageArray withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
//
//    } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
//
//    }];
    [[NetworkRequestManager manager] POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:@"/api/MobileApi/Test" params:self.paramsDic imageArry:self.headerImageArray withLoading:YES isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {

    } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {

    }];
    
   
    
}

@end
