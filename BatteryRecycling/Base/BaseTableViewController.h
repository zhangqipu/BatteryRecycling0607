//
//  BaseTableViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudViewController.h"
#import "UtilsHeader.h"

typedef NS_ENUM(NSInteger, RefreshStyle) {
    RefreshStyleNone,    // 不创建上下拉刷新
    RefreshStyleHead,    // 只有下拉刷新
    RefreshStyleFoot,    // 只有上拉加载
    RefreshStyleBoth     // 上下拉刷新
};


@interface BaseTableViewController : HudViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableArray      *dataSource;

@property (nonatomic, strong) NSString     *url;       // 接口
@property (nonatomic, strong) NSDictionary *paramDic;  // 参数
@property (nonatomic, assign) NSUInteger   page;       // 分页

@property (nonatomic, assign) BOOL         autoDownPullRefresh; // 进入页面是否自动下拉刷新

/**
 *  初始化
 *
 *  @param url      请求的接口
 *  @param paramDic 请求的参数
 *
 *  @return return value description
 */
- (id)initWithUrl:(NSString *)url andParams:(NSDictionary *)paramDic;

/**
 *  重写以完成样式自定义
 *
 */
- (void)createTableViewWithStyle:(UITableViewStyle)style;
- (void)createRefreshWithStyle:(RefreshStyle )style;

- (void)requestForRefresh;
/**
 *  刷新当前页完成
 *
 *  @param responseData 请求接口返回的数据
 */
- (void)requestForRefreshFinish:(id)responseData;

/**
 *  请求下一页完成
 *
 *  @param responseData 请求下一页返回的数据
 */
- (void)reqeustForNextPageFinish:(id)responseData;

@end 
