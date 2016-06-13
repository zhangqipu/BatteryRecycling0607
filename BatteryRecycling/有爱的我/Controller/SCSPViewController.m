//
//  SCSPViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "SCSPViewController.h"
#import "UtilsHeader.h"
#import "SCSPTableViewCell.h"
#import "SPXQViewController.h"

@interface SCSPViewController ()

@end

@implementation SCSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏商品";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCSPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"SCSPTableViewCell");
    }
    
    // config cell
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    [cell configCell:modelDic];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    SPXQViewController *vc = [[SPXQViewController alloc] init];
    vc.goodsId = dic[@"_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - RequestFinish

/**
 *  请求订单列表完成
 *
 *  @param responseData 请求完数据
 */

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    [self.tableView reloadData];
}

- (void)reqeustForNextPageFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    [self.tableView reloadData];
}

- (void)createRefreshWithStyle:(RefreshStyle)style
{
    [super createRefreshWithStyle:RefreshStyleBoth];
}

@end
