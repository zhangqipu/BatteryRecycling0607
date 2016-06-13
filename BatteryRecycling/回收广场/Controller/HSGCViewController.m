//
//  HSGCViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "HSGCViewController.h"
#import "HSGCTableViewCell.h"
#import "UtilsHeader.h"
#import "TableHeaderView.h"
#import <CoreLocation/CoreLocation.h>
#import "TableViewFootView.h"
#import "FinishViewController.h"
#import "XXViewController.h"
#import "GWCViewController.h"

#define kindex 1000
@interface HSGCViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) TableHeaderView *headerView;
@property (strong, nonatomic) TableViewFootView *footView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) NSMutableArray *textFields;

/*
 * 记录填写数量
 */
@property (strong, nonatomic) NSMutableArray *nums;
@property (assign, nonatomic) NSInteger tableViewCount;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *area;

@property (strong, nonatomic) NSMutableDictionary *postData;
@end

@implementation HSGCViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSuberView];
    
    [self requestForBatteryInfoList];
    [self requestLoveData];
    [self setUpLocation];
    [ToolsObj requestGwc];
}

- (void)initSuberView
{
    _tebleView.delegate = self;
    _tebleView.dataSource = self;
    _tebleView.allowsSelection = NO;
    
    _headerView = LOADNibName(@"TableHeaderView");
    _headerView.height = [ToolsObj height:153] + 10 + 97;
    _footView = LOADNibName(@"TableViewFootView");
    
    kWeekSelf
    _footView.moreBlock = ^(UIButton *btn){
        [weakSelf moreAction:btn];
    };
    
    _footView.postBlock = ^(){
        [weakSelf subimAction:nil];
    };
    
    self.tebleView.tableHeaderView = _headerView;
    
    self.tebleView.tableFooterView = _footView;
    
    self.tebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataSource = [NSMutableArray array];
    _postData = [NSMutableDictionary dictionary];
    _textFields = [NSMutableArray array];
    _nums = [NSMutableArray array];
    
     _tableViewCount = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationSate) name: UserLoginStatusNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setShoppingCard) name: ShoppingCartChangeNotification object:nil];
}

- (void)NotificationSate
{
    [self requestForBatteryInfoList];
    [ToolsObj requestGwc];
}

/*
 * 定位
 */
- (void)setUpLocation
{
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    //如果没有授权则请求用户授权
   if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=1000.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    _geocoder=[[CLGeocoder alloc]init];
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
}

-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
        [_headerView.adrBtn setTitle:[NSString stringWithFormat:@"%@-%@", placemark.addressDictionary[@"City"], placemark.addressDictionary[@"SubLocality"]] forState:UIControlStateNormal];
        _province = placemark.addressDictionary[@"SubLocality"];
        _city = placemark.addressDictionary[@"City"];
        _area = placemark.addressDictionary[@"State"];
        
    }];
   //如果不需要实时定位，使用完即使关闭定位服务
     [_locationManager stopUpdatingLocation];
}


/*
 * 发布出去
 */
- (void)subimAction:(UIButton *)sender
{
    if (kIsLogin){
        [_postData setValue:StandardUserDefautsGet(@"user")[@"_id"] forKey:@"publisherId"];
        [_postData setValue:_province forKey:@"province"];
        [_postData setValue:_city forKey:@"city"];
        [_postData setValue:_area forKey:@"area"];
        
        NSMutableArray *detail = [NSMutableArray array];
        
        for (int i = 0; i < _nums.count; i ++) {
            if (![_nums[i] isEqualToString:@""]) {
                [detail addObject:@{@"brNumber":self.dataSource[i][@"number"], @"brName":self.dataSource[i][@"name"],@"qty":_nums[i]}];
            }
        }
        
        if (detail.count > 0) {
            [_postData setValue:detail forKey:@"detail"];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
            [manager POST:[NSString stringWithFormat:@"%@?token=%@",kBatteryTypeOrderAdd,StandardUserDefautsGet(@"token")] parameters:_postData success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                if ([responseObject[@"success"] boolValue] == true) {
                    for (int i = 0; i < _nums.count; i ++) {
                        _nums[i] = @"";
                    }
                    _footView.priceLab.text = @"0.00元";
                    [self.tebleView reloadData];
                    
                    FinishViewController *vc = [[FinishViewController alloc] init];
                    vc.navTitle = @"发布手中废旧电池信息";
                    vc.str1 = @"废旧电池清单发布成功！";
                    vc.str2 = @"请耐心等待回收商联系";
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                
            }];
        } else {
            [self showInfoView:@"请填写数量" infoType:InfoTypeSucceed];
        }
    } else {
        [self showInfoView:@"请先登陆哦~" infoType:InfoTypeSucceed];
    }
}

/*
 * 查看更多
 */
- (void)moreAction:(UIButton *)sender {
    
//    sender.enabled = YES;
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _tableViewCount = self.dataSource.count;
        [self.tebleView reloadData];
    } else {
        _tableViewCount = 3;
        [self.tebleView reloadData];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSGCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = LOADNibName(@"HSGCTableViewCell");
    }
    
    // config cell
    NSDictionary *modelDic = _dataSource[indexPath.row];
    [_textFields addObject:cell.text];
    cell.text.tag = indexPath.row + kindex;
    [cell.text addTarget:self action:@selector(TextFieldChang:) forControlEvents:UIControlEventEditingChanged];
    
    [cell configCell:modelDic];
    cell.text.text = _nums[indexPath.row];
    
    return cell;
}

- (void)TextFieldChang:(UITextField *)textField
{
    NSInteger index = textField.tag - kindex;
    _nums[index] = textField.text;
    CGFloat price = 0;
    for (int i = 0; i < _nums.count; i ++) {
        CGFloat maxPrice =  [[NSString stringWithFormat:@"%@", self.dataSource[i][@"maxPrice"]] floatValue];
        CGFloat num = [[NSString stringWithFormat:@"%@", _nums[i]] floatValue];
        price = maxPrice * num + price;
    }
   _footView.priceLab.text = [NSString stringWithFormat:@"%.2f元", price];
}

#pragma mark - Request

/**
 *  请求电池列表信息
 */
- (void)requestForBatteryInfoList
{
    if (kIsLogin == YES){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager GET:kBatteryType
          parameters:@{@"token":StandardUserDefautsGet(@"token")}
             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                 if ([responseObject[@"success"] boolValue] == true) {
                     [self requestForBatteryInfoListFinish:responseObject];
                 }
             } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                 NSLog(@"%@", error);
             }];
    }
    
}

- (void)requestForBatteryInfoListFinish:(id)reponseObject
{
    if (reponseObject == nil) return ;
    
    [_dataSource addObjectsFromArray:reponseObject[@"result"]];
    
    if (self.dataSource.count >= 3) {
        _tableViewCount = 3;
    } else {
        _tableViewCount = self.dataSource.count;
    }
    
    for (int i = 0; i < self.dataSource.count; i ++) {
        [_nums addObject:@""];
    }
    
    [self.tebleView reloadData];
}

- (void)requestLoveData
{
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:kLoveData
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             [self requestFnishLoveData:responseObject];
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
         }];
}

- (void)requestFnishLoveData:(id)responseObject
{
    [_headerView setModel:responseObject[@"result"]];
}

/*
 * 消息
 */
- (IBAction)messageAction:(UIButton *)sender {
    
    XXViewController *vc = [[XXViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@&operatorId=%@", kMessageGetAll, StandardUserDefautsGet(@"token"), StandardUserDefautsGet(@"user")[@"_id"]] andParams:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 * 购物车
 */
- (IBAction)GWCAction:(UIButton *)sender {
    
    GWCViewController *vc = [[GWCViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@?token=%@", kCart, StandardUserDefautsGet(@"token")] andParams:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setShoppingCard
{
     _gwcNumLab.text = [NSString stringWithFormat:@"%@",StandardUserDefautsGet(@"gwcnum")];
}

@end
