//
//  SelectTeachrsViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "SelectTeachrsViewController.h"
#import "PublicFistTableViewController.h"

@interface SelectTeachrsViewController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SelectTeachrsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setValue:[MyLogInUserManager manager].userData.htGartenId forKey:@"Id"];
    [[NetworkRequestManager manager] POST_URL_HttpHeader:HTTPHEADER_URL url:URL_GartenStaffList params:params withLoading:YES isFailureAlter:YES successBlock:^(NSURLSessionTask * _Nonnull task, id  _Nonnull dataSource) {
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
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPHEADER_URL,dataDic[@"Avatar"]]] placeholderImage:[TJToolsClass getHeaderPlaceholderImage]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",dataDic[@"RealName"]];
    cell.subLabel.text = @"";
    cell.phoneButton.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(selectTeachrDic:row:type:)]) {
        NSDictionary * dataDic = self.dataArray[indexPath.row];
        [self.delegate selectTeachrDic:dataDic row:self.row type:self.type];
        [self.navigationController popViewControllerAnimated:YES];
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
