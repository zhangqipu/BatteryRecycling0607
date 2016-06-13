//
//  YADWViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "YADWViewController.h"
#import "UtilsHeader.h"
#import "YADWHeaderView.h"
#import "LogOutHeaderView.h"
#import "LogViewController.h"
#import "YADWTableViewCell.h"
#import "SCSPViewController.h"
#import "WDQBViewController.h"
#import "WDHBBViewController.h"
#import "WDAXSJViewController.h"
#import "SQHSSViewController.h"
#import "GRZIViewController.h"
#import "DFKViewController.h"
#import "DSHViewController.h"
#import "DPJViewController.h"
#import "TKViewController.h"
#import "FBDDViewController.h"
#import "HSDDViewController.h"
#import "SZHSJGViewController.h"

@interface YADWViewController ()

@property (copy, nonatomic) YADWHeaderView *headerView;
@property (copy, nonatomic) LogOutHeaderView *logOutHeader;

@end

@implementation YADWViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self loginOrLogOut];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initSuberView];
    
}

- (void)initSuberView
{
    self.dataSource = [NSMutableArray arrayWithObjects:@[@"发布电池订单",@"回收电池订单"],@[@"我的爱心数据",@"我的钱包",@"我的环保币",@"收藏商品",@"申请成为回收商",@"设置回收价格"],nil];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOrLogOut) name: UserLoginStatusNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOrLogOut) name: UserLogOutStatusNotification object:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)showNavBackItem:(BOOL)isShow
{
    [super showNavBackItem:NO];
}

- (void)loginOrLogOut
{
    
    kWeekSelf
    
    NSLog(@"--------%d",kIsLogin);
    
    if (kIsLogin) {
        _headerView = LOADNibName(@"YADWHeaderView");
        self.tableView.tableHeaderView = _headerView;
        _headerView.userNameLab.text = StandardUserDefautsGet(@"user")[@"name"];
        _headerView.userIDlAB.text = [NSString stringWithFormat:@"ID:%@",StandardUserDefautsGet(@"user")[@"phone"]];
        _headerView.editDataBlock = ^(){
            GRZIViewController *vc = [GRZIViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.orderBlock = ^(NSInteger tag){
            [weakSelf orderAction:tag];
        };
    } else {
        _logOutHeader = LOADNibName(@"LogOutHeaderView");
        self.tableView.tableHeaderView = _logOutHeader;
        _logOutHeader.pushBlock = ^(){
            [weakSelf pushLogin];
        };
    }
}

/*
 * 购物订单
 */
- (void)orderAction:(NSInteger)tag
{
    switch (tag) {
        case 1:
        {
            // 过滤掉等待付款的订单
//            NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"等待付款\"}]";
            NSString *getUrl = [NSString stringWithFormat:@"%@?token=%@&%@",
                                kOrder, StandardUserDefautsGet(@"token"), @""]; // 等待付款没有数据先去掉过滤
            getUrl = [getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            DFKViewController *vc = [[DFKViewController alloc] initWithUrl:getUrl andParams:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
//            NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"等待收货\"}]";
            NSString *getUrl = [NSString stringWithFormat:@"%@?token=%@&%@",
                                kOrder, StandardUserDefautsGet(@"token"), @""]; // 等待收货没有数据先去掉过滤
            getUrl = [getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSDictionary *paramDic = @{@"token":StandardUserDefautsGet(@"token"),
                                       @"filter":@[@{@"state":@"ToPay"}]};
            DSHViewController *vc = [[DSHViewController alloc] initWithUrl:kOrder andParams:paramDic];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            // 后台是不是少一个待评价的状态
//            NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"交易成功\"}]";
            NSString *getUrl = [NSString stringWithFormat:@"%@?token=%@&%@",
                                kOrder, StandardUserDefautsGet(@"token"), @""]; // 交易成功没有数据先去掉过滤
            getUrl = [getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            DPJViewController *vc = [[DPJViewController alloc] initWithUrl:getUrl andParams:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            // 这里退款申请状态是不是等待退款
//            NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"退款申请\"}]";
            NSString *getUrl = [NSString stringWithFormat:@"%@?token=%@&%@",
                                kOrder, StandardUserDefautsGet(@"token"), @""]; // 等待退款没有数据先去掉过滤
            getUrl = [getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            TKViewController *vc = [[TKViewController alloc] initWithUrl:getUrl andParams:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)pushLogin
{
    LogViewController *vc = [LogViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YADWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = LOADNibName(@"YADWTableViewCell");
    }
    
    cell.lab.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.row == [self.dataSource[indexPath.section] count] - 1) {
        [cell.line removeFromSuperview];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                // 发布订单
                NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"交易成功\"}]";
                NSString *urlStr = [[NSString stringWithFormat:@"%@?token=%@&%@",
                                    kBatteryRecyclingOrder, StandardUserDefautsGet(@"token"), filter] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                FBDDViewController *vc = [[FBDDViewController alloc] initWithUrl:urlStr andParams:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1: {
                // 回收订单
                NSString *filter = @"filter=[{\"property\":\"state\",\"value\":\"交易成功\"}]";
                NSString *urlStr = [[NSString stringWithFormat:@"%@?token=%@&%@",
                                    kBatteryRecyclingOrder, StandardUserDefautsGet(@"token"), filter] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

                HSDDViewController *vc = [[HSDDViewController alloc] initWithUrl:urlStr andParams:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
        }
    } else {
        switch (indexPath.row) {
            case 0:{
                WDAXSJViewController *vc = [WDAXSJViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                // 过滤掉交易成功的数据即是交易记录
                WDQBViewController *vc = [[WDQBViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@&operatorId=%@&type=RMB",kAccount, StandardUserDefautsGet(@"token"),StandardUserDefautsGet(@"user")[@"_id"]] andParams:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                WDHBBViewController *vc = [[WDHBBViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@&operatorId=%@&type=HBB",kAccount, StandardUserDefautsGet(@"token"),StandardUserDefautsGet(@"user")[@"_id"]] andParams:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:{
                SCSPViewController *vc = [[SCSPViewController alloc] initWithUrl:kFavorites andParams:@{@"token":StandardUserDefautsGet(@"token")}];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 4:{
                SQHSSViewController *vc = [SQHSSViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
        }
                break;
            case 5: {
                SZHSJGViewController *vc = [[SZHSJGViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@", kBatteryType, StandardUserDefautsGet(@"token")] andParams:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (void)createRefreshWithStyle:(RefreshStyle)style
{
    [super createRefreshWithStyle:RefreshStyleNone];
}

@end
