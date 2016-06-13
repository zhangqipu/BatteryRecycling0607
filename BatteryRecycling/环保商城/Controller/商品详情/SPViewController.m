//
//  SPViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SPViewController.h"
#import "SPHeaderView.h"
#import "SDCycleScrollView.h"
#import "GLSPTableViewCell.h"
#import "PJTableViewCell.h"

@interface SPViewController ()

@property (nonatomic, strong) SPHeaderView *headerView;
@property (nonatomic, strong) SDCycleScrollView *scrollView;

@end

@implementation SPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSuberView];
//    [self requestGlsp];
}

- (void)initSuberView
{
    self.tableView.top = 104;
    self.tableView.height = SCREEN_HEIGHT - 64 - 40 - 49;
    
    _headerView = LOADNibName(@"SPHeaderView");
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [ToolsObj height:200] + 177);
    
    _scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ToolsObj height:200])];
    
    [_headerView addSubview:_scrollView];
    
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 203;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        GLSPTableViewCell *glspCell = [tableView dequeueReusableCellWithIdentifier:@"glspCell"];
        
        if (glspCell == nil) {
            glspCell = LOADNibName(@"GLSPTableViewCell");
        }
        
        return glspCell;
    } else {
        PJTableViewCell *pjCell = [tableView dequeueReusableCellWithIdentifier:@"pjCell"];
        
        if (pjCell == nil) {
            pjCell = LOADNibName(@"PJTableViewCell");
        }
        
        return pjCell;
    }
    
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.dataSource addObjectsFromArray:responseData[@"result"]];
    if (self.dataSource.count != 0) {
        _shangPinBlock(self.dataSource[0]);
    } else {
        _shangPinBlock([NSDictionary dictionary]);
    }
    [self setUpHeader];
    
}

- (void)setUpHeader
{
    if (self.dataSource.count != 0) {
        NSDictionary *dic = self.dataSource[0];
        
        NSMutableArray *imageUrls = [NSMutableArray array];
        [imageUrls addObject:dic[@"picUrls"]];
        [imageUrls addObject:dic[@"mainPicUrl"]];
        _scrollView.imageURLStringsGroup = imageUrls;
        _scrollView.placeholderImage = kNoPicture;
        
        [_headerView setModel:dic];
    }
    
}

/*
 * 请求关联商品
 */
- (void)requestGlsp
{
    NSString *url1 = [[NSString stringWithFormat:@"%@?token=%@&%@", kGoods, StandardUserDefautsGet(@"token"), @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager GET:url1 parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

@end
