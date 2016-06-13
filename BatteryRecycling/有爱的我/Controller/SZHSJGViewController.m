//
//  SZHSJGViewController.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/19.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SZHSJGViewController.h"
#import "SZHSDDTableViewCell.h"

#import "UtilsHeader.h"
#import "SZHSDDFooterView.h"
#import "SZHSDDHeaderView.h"

#import "CitysViewController.h"

#define kCellHeight 55

@interface SZHSJGViewController ()

@end

@implementation SZHSJGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpHeaderAndFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHeaderAndFooterView
{
    SZHSDDHeaderView *headerView = LOADNibName(@"SZHSDDHeaderView");
    SZHSDDHeaderView *weakHeaderView = headerView;
    headerView.SZHSDDButtonActionBlock = ^() {
        CitysViewController *vc =[CitysViewController new];
        vc.cityBlock = ^(NSString *citys, NSString *province, NSString *city, NSString *area){
            NSString *address = province ? province : @"";
            address = [address stringByAppendingString:city ? [NSString stringWithFormat:@"-%@", city] : @""];
            address = [address stringByAppendingString:area ? [NSString stringWithFormat:@"-%@", area] : @""];
            [weakHeaderView.szhsddButton setTitle:address forState:UIControlStateNormal];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };

    self.tableView.tableHeaderView = headerView;
    
    SZHSDDFooterView *footerView = LOADNibName(@"SZHSDDFooterView");
    footerView.saveSettedPriceBlock = ^() {
        [self requestForSettingPrice];
    };
    
    self.tableView.tableFooterView = footerView;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZHSDDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"SZHSDDTableViewCell");
    }

    // config cell
    NSDictionary *modelDic = self.dataSource[indexPath.row];
    [cell configCell:modelDic];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return LOADNibName(@"SZHSDDGroupHeaderView");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54.f;
}

#pragma mark - HttpRequests

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    [self.tableView reloadData];
}

- (void)requestForSettingPrice
{
    NSDictionary *paramDic = @{
                               @"_id":@"573599e5c1babb3039a9adc3",
                               @"type":@"priceSetting",
                               @"priceSetting":@[@{@"brNumber":@"1463130597358",@"brName":@"大家圣诞节",@"price":@0.98}]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager POST:[NSString stringWithFormat:@"%@?token=%@", kUserUpdateUserInfo, StandardUserDefautsGet(@"token")] parameters:paramDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self showInfoView:@"设置成功!" infoType:InfoTypeSucceed];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];

}

@end
