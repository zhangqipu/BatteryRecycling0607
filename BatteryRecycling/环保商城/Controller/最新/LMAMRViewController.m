//
//  LMAMRViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 12/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "LMAMRViewController.h"
#import "LMATableViewCell.h"
#import "UtilsHeader.h"
#import "SPXQViewController.h"

@interface LMAMRViewController ()

@end

@implementation LMAMRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
}

- (void)initSuberView
{
    self.tableView.top = 64 + 50;
    self.tableView.height = SCREEN_HEIGHT - 50 - 64;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = LOADNibName(@"LMATableViewCell");
    }
    [cell setModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    SPXQViewController *vc = [[SPXQViewController alloc] init];
    vc.goodsId = dic[@"_id"];
    [self.nav pushViewController:vc animated:YES];
    
}

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
