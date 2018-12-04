//
//  HomeManagementViewController.m
//  HostingTeacher
//
//  Created by 清 on 2018/11/21.
//  Copyright © 2018 清. All rights reserved.
//

#import "HomeManagementViewController.h"
#import "HomeManagerCollectionViewCell.h"
#import "HomeManagerCollectionReusableView.h"
#import "JHScrollView.h"
#import "TeachersManagementViewController.h"
#import "ClassManagementViewController.h"
#import "StudentsManagementViewController.h"
#import "AttendanceManagementViewController.h"
#import "SchoolBulletinViewController.h"


@interface HomeManagementViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,lunBoScrollViewDelegate>
@property(nonatomic,strong)NSArray * headerTitleArray;
@property(nonatomic,strong)NSArray * itemArray;
@property(nonatomic,strong)JHScrollView * jhScrollView;
@end

@implementation HomeManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"sccell"];
    self.headerTitleArray = @[@"",@"常用应用",@"教学管理"];
    NSArray * array1 = @[@""];
    NSArray * array2 = @[@{@"image":@"ydaoxiaolixiao",@"title":@"到校离校"},@{@"image":@"ymeirishipu",@"title":@"每日食谱"},@{@"image":@"yxiaoqugonggao",@"title":@"校区公告"},@{@"image":@"yshouzhang",@"title":@"手账"}];
    NSArray * array3 = @[@{@"image":@"ylaoshiguanli",@"title":@"老师管理"},@{@"image":@"yxueshengguanli",@"title":@"学生管理"},@{@"image":@"ybanjiguanli",@"title":@"班级管理"},@{@"image":@"ymeiridianping",@"title":@"每日点评"}];
    self.itemArray = @[array1,array2,array3];
    self.jhScrollView = [[JHScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 180)];
    self.jhScrollView.tag = 100;
    self.jhScrollView.delegate = self;
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    [imageArray addObject:@"http://08imgmini.eastday.com/mobile/20181122/20181122_a8c9dc792f0566add267448bcdd5c994_cover_mwpm_03200403.jpg"];
    [imageArray addObject:@"http://01imgmini.eastday.com/mobile/20181122/20181122_03988a1a98fc53dbff4b244eb97a25fe_cover_mwpm_03200403.jpg"];
    [imageArray addObject:@"http://02imgmini.eastday.com/mobile/20181122/20181122171417_708a1f7044913126242ecee63aed5184_1_mwpm_03200403.jpg"];
    self.jhScrollView.imageArr = imageArray;
    
    
}

//选中第几个轮播图片
-(void)lunboScrollViewDelegate:(JHScrollView *)lunboView didSelectIndex:(NSInteger)index{
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreen_Width, 180);
    }
    return (CGSize){kScreen_Width/3,90};
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    return (CGSize){kScreen_Width,44};
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.itemArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.itemArray[section] count];
}
#pragma mark ---- UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //滚动视图
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sccell" forIndexPath:indexPath];
        if ([cell.contentView viewWithTag:100] == nil) {
            [cell.contentView addSubview:self.jhScrollView];
        }
        return cell;
    }
    HomeManagerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray * array = self.itemArray[indexPath.section];
    NSDictionary * dic = array[indexPath.row];
    cell.icImageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.titleLabel.text = dic[@"title"];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeManagerCollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"rcell" forIndexPath:indexPath];
        headerView.titleLabel.text = self.headerTitleArray[indexPath.section];
        return headerView;
    }
    return nil;
}
 
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //考勤管理
            AttendanceManagementViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceManagementViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            //每日食谱
            
        }else if (indexPath.row == 2) {
            //校区公告
            SchoolBulletinViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SchoolBulletinViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            //手账
            
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            //教师管理
            TeachersManagementViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TeachersManagementViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            //学生管理
            StudentsManagementViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentsManagementViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            //班级管理
            ClassManagementViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassManagementViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
