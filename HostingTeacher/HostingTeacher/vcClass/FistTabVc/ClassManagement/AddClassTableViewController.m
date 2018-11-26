//
//  AddClassTableViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/26.
//  Copyright © 2018 清. All rights reserved.
//

#import "AddClassTableViewController.h"
#import "SelectTeachrsViewController.h"

@interface AddClassTableViewController ()<SelectTeachrsDelegate>
@property(nonatomic,strong)NSMutableDictionary * paramsDic;
@end

@implementation AddClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.paramsDic = [[NSMutableDictionary alloc]init];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
        SelectTeachrsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectTeachrsViewController"];
        vc.delegate = self;
        vc.row = indexPath.row;
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)selectTeachrDic:(NSDictionary *)dicModel row:(NSInteger)row type:(NSInteger)type{
    
    if (row == 1) {
        self.zhujiaoLabel.text = dicModel[@"RealName"];
    }else if (row == 2) {
        self.fujiao1Label.text = dicModel[@"RealName"];
    }else if (row == 3) {
        self.fujiao2Label.text = dicModel[@"RealName"];
    }
}
- (IBAction)saveAction:(id)sender {
    
    [self.view endEditing:YES];
    if (self.classNameLabel.text.length < 1) {
        [MyAlerView alterMessage:@"班级名称不能为空"];
        return;
    }
    if (self.zhujiaoLabel.text.length < 1) {
        [MyAlerView alterMessage:@"主教老师不能为空"];
        return;
    }
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
- (IBAction)delButtonAction:(id)sender {
}

@end
