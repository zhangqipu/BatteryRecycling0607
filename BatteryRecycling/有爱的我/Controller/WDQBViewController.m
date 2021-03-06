//
//  WDQBViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "WDQBViewController.h"
#import "WDQBHeaderView.h"
#import "WDQBTableViewCell.h"
#import "UtilsHeader.h"

@interface WDQBViewController ()

@property (strong, nonatomic) WDQBHeaderView *headerView;
@end

@implementation WDQBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self initSuberView];
}

- (void)initSuberView
{
    _headerView = LOADNibName(@"WDQBHeaderView");
    
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.allowsSelection = NO;

}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDQBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"WDQBTableViewCell");
    }
    

    // config cell
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
    [self.dataSource addObjectsFromArray:responseData[@"results"][@"inOutList"]];
    
    _headerView.lab.text = [NSString stringWithFormat:@"余额:%@元", responseData[@"results"][@"balance"]];
    
    [self.tableView reloadData];
}

@end
