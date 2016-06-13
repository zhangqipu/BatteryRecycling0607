//
//  LMCViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 20/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "LMCViewController.h"
#import "UtilsHeader.h"
#import "LMCTableViewCell.h"

@interface LMCViewController ()

@end

@implementation LMCViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"热销";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ToolsObj height:160];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"LMCTableViewCell");
    }
    NSDictionary *model = self.dataSource[indexPath.row];
    
    cell.nameLab.text = model[@"name"];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model[@"mainPicUrl"]] placeholderImage:kNoPicture];
    
    return cell;
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    [self.tableView reloadData];
}

@end
