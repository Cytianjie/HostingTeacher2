//
//  ClassManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "ClassManagementViewController.h"
#import "TeachersManagementTableViewCell.h"
#import "PublicFistTableViewController.h"

@interface ClassManagementViewController ()
@property(nonatomic,assign)BOOL isCreatVc;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ClassManagementViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
//    [params setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"Id"];
//    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_GartenStaffList params:params withLoading:self.isCreatVc isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
//        self.isCreatVc = NO;
//        [self.dataArray removeAllObjects];
//        NSDictionary * dataSourceDic = dataSource;
//        NSArray * data = dataSourceDic[@"data"];
//        if ([data isKindOfClass:[NSArray class]]) {
//            [self.dataArray addObjectsFromArray:data];
//            [self.tableView reloadData];
//        }
//    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
//
//    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCreatVc = YES;
    self.dataArray = [[NSMutableArray alloc]init];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicFistTableViewController * publicTableViewVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
    TeachersManagementTableViewCell *cell = [publicTableViewVc.tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.headerImageView.image = [UIImage imageNamed:@"fbanji"];
    cell.nameLabel.text = @"11";
    cell.subLabel.text = @"222";
    cell.phoneButton.hidden = YES;
    cell.headerImageView.layer.cornerRadius = 5;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
