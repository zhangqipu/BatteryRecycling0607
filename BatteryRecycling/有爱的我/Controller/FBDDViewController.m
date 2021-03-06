//
//  FBDDViewController.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/17.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "FBDDViewController.h"
#import "FBDDTableViewCell0.h"

#define kCellHeight 328
#define kCellHeight1 304

@interface FBDDViewController ()

@end

@implementation FBDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布订单";
    
    [self initSuberView];
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
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    NSString *stateStr = modelDic[@"state"];
    CGFloat cellH = 0;
    
    if ([stateStr isEqualToString:@"正在派单"] || [stateStr isEqualToString:@"等待交易"]) {
        cellH = kCellHeight;
    }
    
    if ([stateStr isEqualToString:@"交易取消"] || [stateStr isEqualToString:@"交易成功"]) {
        cellH = kCellHeight1;
    }
    
    return cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBDDTableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    NSString *stateStr = modelDic[@"state"];
    NSUInteger kind = 0;
    
    if ([stateStr isEqualToString:@"正在派单"]) {
        kind = 0;
    }
    if ([stateStr isEqualToString:@"等待交易"]) {
        kind = 1;
    }
    if ([stateStr isEqualToString:@"交易取消"] || [stateStr isEqualToString:@"交易成功"]) {
        kind = 2;
    }
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"FBDDTableViewCell%lu", (unsigned long)kind] owner:self options:nil][0];
    }

    // config cell
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
