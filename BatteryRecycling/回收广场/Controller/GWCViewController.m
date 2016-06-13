//
//  GWCViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "GWCViewController.h"
#import "GWCSCViewController.h"
#import "GWCFootView.h"

@interface GWCViewController ()

@property (nonatomic, strong) GWCFootView *footView;
@property (nonatomic, strong) NSMutableArray *seleltedArr;

@end

@implementation GWCViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self initSuberView];
}

- (void)initSuberView
{
    _footView = LOADNibName(@"GWCFootView");
    _footView.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [self.view addSubview:_footView];
    
    kWeekSelf
    _footView.quanXuanBlock = ^(UIButton *btn){
        if (btn.selected == NO) {
            for (int i = 0; i < _seleltedArr.count; i ++) {
                weakSelf.seleltedArr[i] = @"0";
            }
        } else {
            for (int i = 0; i < _seleltedArr.count; i ++) {
                weakSelf.seleltedArr[i] = @"1";
            }
        }
        [weakSelf calculation];
        [weakSelf.tableView reloadData];
    };
    
    self.tableView.height = SCREEN_HEIGHT - 49;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(bianJiAction)];    
    self.navigationItem.rightBarButtonItem = item;
    
    _seleltedArr = [NSMutableArray array];
    
}

- (void)bianJiAction
{
    GWCSCViewController *vc = [[GWCSCViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@", kCart, StandardUserDefautsGet(@"token")] andParams:nil];
    vc.deleteIndexSet = ^(NSMutableIndexSet *set){
        [self.dataSource removeObjectsAtIndexes:set];
        [_seleltedArr removeObjectsAtIndexes:set];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = LOADNibName(@"GWCTableViewCell");
    }
    
    [cell setModel:self.dataSource[indexPath.row]];
    
    if ([_seleltedArr[indexPath.row] isEqualToString:@"1"]) {
        cell.xuanzhongBtn.selected = YES;
    } else {
        cell.xuanzhongBtn.selected = NO;
    }
    
    cell.xuanZhongBlock = ^(UIButton *btn){
        if (btn.selected == YES) {
             _seleltedArr[indexPath.row] = @"1";
        } else {
             _seleltedArr[indexPath.row] = @"0";
        }
        [self calculation];
    };
    
    cell.numBlock = ^(NSInteger num){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[indexPath.row]];
        
        dic[@"qty"] = [NSString stringWithFormat:@"%ld",num];
        
        self.dataSource[indexPath.row] = dic;
        
        [self calculation];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    for (int i = 0; i < self.dataSource.count; i ++) {
        [_seleltedArr addObject:@"1"];
    }
    
    [self calculation];
    [self.tableView reloadData];
}


/*
 * 计算合计总额
 */
- (void)calculation
{
    
/*
 *  sub1 金钱   sub2 件数
 */
    CGFloat sub1 = 0;
    CGFloat sub2 = 0;
    for (int i = 0;  i < self.dataSource.count; i ++) {
        if ([_seleltedArr[i] isEqualToString:@"1"]){
            NSDictionary *dic = self.dataSource[i];
            CGFloat a = [dic[@"qty"] floatValue];
            CGFloat b = [dic[@"price"] floatValue];
            sub1 += a * b;
            sub2 += a;
        }
    }
    
    _footView.subLab.text = [NSString stringWithFormat:@"合计:%.2f元", sub1];
    [_footView.postBtn setTitle:[NSString stringWithFormat:@"去结算(%.f)",sub2] forState:UIControlStateNormal];
    
}


- (void)createRefreshWithStyle:(RefreshStyle)style
{
    [super createRefreshWithStyle:RefreshStyleFoot];
}

@end
