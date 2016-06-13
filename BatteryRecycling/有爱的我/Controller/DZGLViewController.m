//
//  DZGLViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "DZGLViewController.h"
#import "UtilsHeader.h"
#import "DZGLTableViewCell.h"
#import "XZDZViewController.h"

@interface DZGLViewController ()

@property (strong, nonatomic) UIView *footView;
@end

@implementation DZGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
    self.title = @"地址管理";
}

- (void)initSuberView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _footView = LOADNibName(@"DZGLFootView");
    self.tableView.tableFooterView = _footView;
    

    self.dataSource = [NSMutableArray arrayWithArray:StandardUserDefautsGet(@"user")[@"addressList"]];
}

// 新增地址
- (IBAction)footViewAction:(UIButton *)sender {
    
    XZDZViewController *vc = [[XZDZViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZGLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"DZGLTableViewCell");
    }
    [cell setModel:self.dataSource[indexPath.row]];
    
    kWeekSelf
    cell.deleteAdr = ^(){
        [weakSelf.dataSource removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView reloadData];
        
        NSMutableArray *address = self.dataSource;
        NSMutableDictionary *user = [NSMutableDictionary dictionaryWithDictionary:StandardUserDefautsGet(@"user")];
        [user setObject:address forKey:@"addressList"];
        StandardUserDefautsSet(user, @"user");
    };
    
    return cell;
}


@end
