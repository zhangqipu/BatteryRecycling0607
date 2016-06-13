//
//  PJViewController.m
//  
//
//  Created by jiasha.huang on 14/5/16.
//
//

#import "PJViewController.h"
#import "SPPJTableViewCell.h"

@interface PJViewController ()

@end

@implementation PJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
}

- (void)initSuberView
{
    self.tableView.top = 104;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *model = self.dataSource[indexPath.row];
    
    CGSize size = [ToolsObj setLableSize:model[@"content"] font:[UIFont systemFontOfSize:11]];
    
    return 140 + size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPPJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"SPPJTableViewCell");
    }
    
    [cell setModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"Comment"]];
    [self.tableView reloadData];
}

@end
