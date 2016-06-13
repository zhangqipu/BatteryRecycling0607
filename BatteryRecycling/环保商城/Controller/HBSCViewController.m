//
//  HBSCViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "HBSCViewController.h"
#import "LMAViewController.h"
#import "HBSCTableViewCell.h"
#import "XSQGViewController.h"
#import "HBSCNavView.h"
#import "LMCViewController.h"
#import "JPViewController.h"
#import "ZHViewController.h"

@interface HBSCViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HBSCNavView *nav;

@end

@implementation HBSCViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
}


- (void)initSuberView
{
    self.dataSource = [NSMutableArray array];
    
    _nav = LOADNibName(@"HBSCNavView");
    _nav.top = 0;
    _nav.width = SCREEN_WIDTH;
    _nav.left = 0;
    [self.view addSubview:_nav];
    
    kWeekSelf
    _nav.messageBlock = ^(){
        [weakSelf messageAction:nil];
    };
    
    _nav.gWCBlock = ^(){
        [weakSelf GWCAction:nil];
    };
    
    _headerView = LOADNibName(@"HBSCHeaderView");
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [ToolsObj height:200] + 104);
    _scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ToolsObj height:200])];
    
    [_headerView addSubview:_scrollView];
    
    self.tableView.tableHeaderView = _headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.top = 44;
    
    [self requesrBanner];
    [self requerst];
    
    
    NSArray *views = [_headerView.subviews[0] subviews];
    
    for (UIView *view in views) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(classificationAction:)];
        [view addGestureRecognizer:tap];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requesrBannerAndrequest) name: UserLoginStatusNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setShoppingCard) name: ShoppingCartChangeNotification object:nil];
}

- (void)setShoppingCard
{
    _nav.gwcNumLab.text = [NSString stringWithFormat:@"%@",StandardUserDefautsGet(@"gwcnum")];
}

- (void)showNavBackItem:(BOOL)isShow
{
    [super showNavBackItem:NO];
}

// 加载横幅
- (void)requesrBanner
{
     _banners = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager GET:[NSString stringWithFormat:@"%@?token=%@", kBanner, StandardUserDefautsGet(@"token")] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *result = responseObject[@"result"];
        for (NSDictionary *dic in result) {
            [_banners addObject:dic[@"picUrl"]];
            [_banners addObject:dic[@"picUrl"]];
        }
        _scrollView.imageURLStringsGroup = _banners;
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

// 加载限时抢购
- (void)requerst
{
    if (kIsLogin) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [manager GET:[NSString stringWithFormat:@"%@?token=%@", kGoodsDiscount, StandardUserDefautsGet(@"token")] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if ([responseObject[@"success"] boolValue] == true) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray: responseObject[@"result"]];
                [self.tableView reloadData];
            } else {
                [self showInfoView:@"限时抢购加载失败" infoType:InfoTypeSucceed];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
    }
}

- (void)requesrBannerAndrequest
{
    [self requerst];
    [self requesrBanner];
}

- (void)classificationAction:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    
    switch (sender.view.tag) {
        case 1:{
            LMAViewController *vc = [[LMAViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            JPViewController *vc = [[JPViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            NSString *filter1 = @"filter=[{\"property\":\"categoryName\",\"value\":\"类目A\"},{\"property\":\"categoryName\",\"value\":\"默认\"}]";
            NSString *url1 = [[NSString stringWithFormat:@"%@?token=%@&%@", kGoods, StandardUserDefautsGet(@"token"), @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            LMCViewController *vc1 = [[LMCViewController alloc] initWithUrl:url1 andParams: nil];
            vc1.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc1 animated:YES];
        }
            break;
        case 4:{
            ZHViewController *vc = [[ZHViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = LOADNibName(@"HBSCTableViewCell");
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    kWeekSelf
    cell.moreDataBlock = ^(){
        XSQGViewController *vc = [[XSQGViewController alloc] initWithUrl:kGoodsDiscount andParams:@{@"token": StandardUserDefautsGet(@"token")}];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [cell setModel:self.dataSource[indexPath.row]];
    
    return cell;
}

/*
 * 消息
 */
- (void)messageAction:(UIButton *)sender {
    
    XXViewController *vc = [[XXViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@&operatorId=%@", kMessageGetAll, StandardUserDefautsGet(@"token"), StandardUserDefautsGet(@"user")[@"_id"]] andParams:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 * 购物车
 */
- (void)GWCAction:(UIButton *)sender {
    
    GWCViewController *vc = [[GWCViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@", kCart, StandardUserDefautsGet(@"token")] andParams:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
