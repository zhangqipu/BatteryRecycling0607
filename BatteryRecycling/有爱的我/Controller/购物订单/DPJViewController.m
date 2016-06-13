//
//  DPJViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "DPJViewController.h"
#import "DPJTableViewCell.h"

@interface DPJViewController ()

@end

@implementation DPJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
    self.title = @"退款";
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
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"DPJTableViewCell");
    }
    
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    [cell configCell:modelDic];

    return cell;
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
