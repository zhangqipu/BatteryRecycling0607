//
//  GWCSCViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "GWCSCViewController.h"
#import "GWCTableViewCell.h"
#import "GWCSCFootView.h"

@interface GWCSCViewController ()

@property (nonatomic, strong) GWCSCFootView *footView;
@property (nonatomic, strong) NSMutableArray *selelted;

@end

@implementation GWCSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    
    [self initSuberView];
}

- (void)initSuberView
{
   
    
    _footView = LOADNibName(@"GWCSCFootView");
    _footView.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [self.view addSubview:_footView];
    
    kWeekSelf
    _footView.deleteBlock = ^(UIButton *btn){
        if (btn.selected == NO) {
            for (int i = 0; i < _selelted.count; i ++) {
                weakSelf.selelted[i] = @"0";
            }
        } else {
            for (int i = 0; i < _selelted.count; i ++) {
                weakSelf.selelted[i] = @"1";
            }
        }
        [weakSelf.tableView reloadData];
    };
    
    _footView.deleteAllBlock = ^(){
        [weakSelf deleteAll];
    };
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(bianJiAction)];    
    self.navigationItem.rightBarButtonItem = item;
    
    
    _selelted = [NSMutableArray array];
}

- (void)bianJiAction
{
    [self.navigationController popViewControllerAnimated:NO];
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
    
    [cell setDeleteModel:self.dataSource[indexPath.row]];
    
    if ([_selelted[indexPath.row] isEqualToString:@"1"]) {
        cell.xuanzhongBtn.selected = YES;
    } else {
        cell.xuanzhongBtn.selected = NO;
    }
    
    cell.xuanZhongBlock = ^(UIButton *btn){
        if (btn.selected == YES) {
            _selelted[indexPath.row] = @"1";
        } else {
            _selelted[indexPath.row] = @"0";
        }
        
    };
    
    cell.numBlock = ^(NSInteger num){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataSource[indexPath.row]];
        
        dic[@"qty"] = [NSString stringWithFormat:@"%ld",num];
        
        self.dataSource[indexPath.row] = dic;
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)deleteAll
{
    NSMutableIndexSet *index = [NSMutableIndexSet indexSet];
    
    for (NSInteger i = 0; i < self.dataSource.count; i ++) {
        
        if ([_selelted[i] isEqualToString:@"1"]) {
            NSDictionary *dic = self.dataSource[i];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
            [manager GET:[NSString stringWithFormat:@"%@/%@?token=%@",kCartDelete,dic[@"_id"], StandardUserDefautsGet(@"token")] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                
            }];
            
            [index addIndex:i];
        }
    }
    
    [self.dataSource removeObjectsAtIndexes:index];
    [_selelted removeObjectsAtIndexes:index];
    
    _deleteIndexSet(index);
    
    [self.tableView reloadData];
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    
    for (int i = 0; i < self.dataSource.count; i ++) {
        [_selelted addObject:@"1"];
    }
    
    [self.tableView reloadData];
}

@end
