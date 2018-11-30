//
//  TeachersManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/22.
//  Copyright © 2018 清. All rights reserved.
//

#import "TeachersManagementViewController.h"
#import "AddTeachersTableViewController.h"
#import "PublicFistTableViewController.h"

@interface TeachersManagementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL isCreatVc;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation TeachersManagementViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"Id"];
    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_GartenStaffList params:params withLoading:self.isCreatVc isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        self.isCreatVc = NO;
        [self.dataArray removeAllObjects];
        NSDictionary * dataSourceDic = dataSource;
        NSArray * data = dataSourceDic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            [self.dataArray addObjectsFromArray:data];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        
    }];
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
    return self.dataArray.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     PublicFistTableViewController * publicTableViewVc = [self.storyboard instantiateViewControllerWithIdentifier:@"PublicFistTableViewController"];
     TeachersManagementTableViewCell *cell = [publicTableViewVc.tableView dequeueReusableCellWithIdentifier:@"cell"];
     NSDictionary * dataDic = self.dataArray[indexPath.row];
     NSDictionary * modelDic = dataDic[@"usermodel"];
     [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPHEADER_URL,modelDic[@"Avatar"]]] placeholderImage:[TJToolsClass getHeaderPlaceholderImage]];
     cell.nameLabel.text = [NSString stringWithFormat:@"%@",modelDic[@"RealName"]];
     cell.subLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"rolename"]];
     [cell.phoneButton addTarget:self action:@selector(phoneButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
     cell.phoneButton.tag = indexPath.row;
     return cell;
 }

-(void)phoneButtonClcik:(UIButton *)button{
    NSDictionary * dataDic = self.dataArray[button.tag];
    NSDictionary * modelDic = dataDic[@"usermodel"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",modelDic[@"Mobile"]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddTeachersTableViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTeachersTableViewController"];
    vc.incomingDataDic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
