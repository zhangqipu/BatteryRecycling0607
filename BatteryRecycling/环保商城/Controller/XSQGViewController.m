//
//  XSQGViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 13/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XSQGViewController.h"
#import "XSQGTableViewCell.h"
#import "XSQGHeader.h"
#import "SPXQViewController.h"

@interface XSQGViewController ()

@property (nonatomic, strong) XSQGHeader *headerView;
@property (nonatomic, strong) NSTimer *time;

@end

@implementation XSQGViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"限时抢购";
    
    [self initSuberView];
}

- (void)initSuberView
{
    _headerView = LOADNibName(@"XSQGHeader");
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    
    self.tableView.tableHeaderView = _headerView;
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
    XSQGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"XSQGTableViewCell");
    }
    
    [cell setModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    SPXQViewController *vc = [[SPXQViewController alloc] init];
    vc.goodsId = dic[@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"][0][@"goodsList"]];
    
    [self.tableView reloadData];
}

@end
