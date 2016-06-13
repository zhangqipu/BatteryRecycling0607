//
//  BaseTableViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UtilsHeader.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)initWithUrl:(NSString *)url andParams:(NSDictionary *)paramDic
{
    if (self = [super init])
    {
        _url = url;
        _paramDic = paramDic;
        _autoDownPullRefresh = YES;
        _dataSource = [NSMutableArray array];
        [self requestForRefresh];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestForRefresh) name: UserLogOutStatusNotification object:nil];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
    
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createTableViewWithStyle:UITableViewStylePlain];
    [self configTableView];
    [self createRefreshWithStyle:RefreshStyleHead];

}

- (void)configTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)createTableViewWithStyle:(UITableViewStyle)style
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.left,
                                                               self.view.top,
                                                               self.view.width,
                                                               self.view.height)
                                              style:style];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"hello";
    return cell;
}
#pragma mark
#pragma mark | ------------------- Post Requests ------------------- |

- (void)requestForRefresh
{
    if (_url == nil && _paramDic == nil){
        [_tableView.mj_header endRefreshing];
        return ;
    }
    
//    [self showLoadingView];
    
    _paramDic = [ToolsObj firstPageParamDictionry:_paramDic];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    //    [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    //    [manager setDataTaskWillCacheResponseBlock:^NSCachedURLResponse * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSCachedURLResponse * _Nonnull proposedResponse) {
    //        return [[NSCachedURLResponse alloc] initWithResponse:proposedResponse.response
    //                                                        data:proposedResponse.data
    //                                                    userInfo:proposedResponse.userInfo
    //                                               storagePolicy:NSURLCacheStorageAllowed];
    //    }];
    [manager GET:_url parameters:_paramDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [_tableView.mj_header endRefreshing];
//        self.tableView.mj_footer.automaticallyChangeAlpha = YES;
        if ([responseObject[@"result"] count] < 5){
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if (responseObject) {
            //                 [self hideLoadingView];
            [self.dataSource removeAllObjects];
            [self requestForRefreshFinish:responseObject];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            //             [self hideLoadingView];
            [_tableView.mj_header endRefreshing];
        }];
}

- (void)checkDataSourceIsThereData
{
    
}

- (void)requestForRefreshFinish:(id)responseData
{
    [self.tableView.mj_header endRefreshing];
}

- (void)requestForNextPage
{
    if (_url == nil && _paramDic == nil) {
        [_tableView.mj_footer endRefreshing];
        return ;
    }
    
    _paramDic = [ToolsObj nextPageParamDictionry:_paramDic];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setDataTaskWillCacheResponseBlock:^NSCachedURLResponse * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSCachedURLResponse * _Nonnull proposedResponse) {
        return [[NSCachedURLResponse alloc] initWithResponse:proposedResponse.response
                                                        data:proposedResponse.data
                                                    userInfo:proposedResponse.userInfo
                                               storagePolicy:NSURLCacheStorageAllowed];
    }];
    
    [manager GET:_url
      parameters:_paramDic
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
             [_tableView.mj_footer endRefreshing];
             self.tableView.mj_footer.automaticallyChangeAlpha = YES;
             if ([responseObject[@"result"] count] < 5){
                [_tableView.mj_footer endRefreshingWithNoMoreData];
             }
             [self reqeustForNextPageFinish:responseObject];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [_tableView.mj_footer endRefreshing];
         }];
}

- (void)reqeustForNextPageFinish:(id)responseData
{
    
}


- (void)createRefreshWithStyle:(RefreshStyle )style
{
    if (style == RefreshStyleBoth)
    {
        [self createDownPullRefresh];
        [self createUpLoadRefresh];
    }
    
    if (style == RefreshStyleHead)
        [self createDownPullRefresh];
    
    if (style == RefreshStyleFoot)
        [self createUpLoadRefresh];
}

/**
 *  创建下拉刷新
 */
- (void)createDownPullRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestForRefresh)];
}

/**
 *  创建上拉加载
 */
- (void)createUpLoadRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self requestForNextPage];
    }];
}


@end
