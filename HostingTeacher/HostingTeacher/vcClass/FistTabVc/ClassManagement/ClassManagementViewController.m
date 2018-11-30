//
//  ClassManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "ClassManagementViewController.h"
#import "PublicFistTableViewController.h"
#import "AddClassTableViewController.h"

@interface ClassManagementViewController ()
@property(nonatomic,assign)BOOL isCreatVc;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ClassManagementViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"gartenid"];
    [[NetworkRequestManager manager]POST_IMAGEURL_HttpHeader:HTTPHEADER_URL url:URL_ClassList params:params imageArry:nil withLoading:self.isCreatVc isFailureAlter:YES success:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
        self.isCreatVc = NO;
        [self.dataArray removeAllObjects];
        NSDictionary * dataSourceDic = dataSource;
        NSArray * data = dataSourceDic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            [self.dataArray addObjectsFromArray:data];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionTask * _Nonnull task, NSString * _Nonnull errorMessage, NSError * _Nullable error) {
        
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
    cell.headerImageView.image = [UIImage imageNamed:@"fbanji"];
    cell.nameLabel.text = dataDic[@"ClassName"];
    cell.subLabel.text = dataDic[@"BishopTeacherName"];
    cell.phoneButton.hidden = YES;
    cell.headerImageView.layer.cornerRadius = 5;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddClassTableViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddClassTableViewController"];
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
