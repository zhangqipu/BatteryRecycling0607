//
//  DFKViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "DFKViewController.h"
#import "DFKTableViewCell.h"

@interface DFKViewController ()

@end

@implementation DFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
    self.title = @"待付款";
}

- (void)initSuberView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 235;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"DFKTableViewCell");
    }
    
    // config cell
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    [cell configCell:modelDic];
    
    cell.deleteOrderBlock = ^(){
    
    };
    
    cell.toPayBlock = ^(){
    
    };
    
    return cell;
}

- (void)deleteOrder:(NSInteger)index
{
    
}

- (void)toPayOrder:(NSInteger)index
{

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


@end
