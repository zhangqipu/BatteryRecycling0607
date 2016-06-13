//
//  QRDDViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 19/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "QRDDViewController.h"
#import "QRDDHeaderView.h"
#import "QRDDTableViewCell.h"

@interface QRDDViewController ()

@property (strong, nonatomic) QRDDHeaderView *headerView;

@end

@implementation QRDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    [self initSuberView];
}

- (void)initSuberView
{
    _headerView = LOADNibName(@"QRDDHeaderView");
    self.tableView.tableHeaderView = _headerView;
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 263;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QRDDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"QRDDTableViewCell");
    }
    
    cell.num = @"1";
    
    [cell setModel:_models[indexPath.row]];
    
    return cell;
}

@end
