//
//  XXViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XXViewController.h"
#import "XXTableViewCell.h"

@interface XXViewController ()

@end

@implementation XXViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"消息通知";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"XXTableViewCell");
    }
    
//    [cell setModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:@[@"1",@"1",@"1"]];

//    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    [self.tableView reloadData];
}

@end
