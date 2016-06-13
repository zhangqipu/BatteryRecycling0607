//
//  XQViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XQViewController.h"

@interface XQViewController ()

@end

@implementation XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
}

- (void)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    NSString *filter1 = [NSString stringWithFormat:@"filter=[{\"property\":\"_id\",\"value\":\"%@\"}]", _goodsId];
    
    NSString *url1 = [[NSString stringWithFormat:@"%@?token=%@&%@",kGoods, StandardUserDefautsGet(@"token"), filter1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [manager GET:url1 parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *arr = responseObject[@"result"];
        if (arr.count != 0) {
            [self requestFinish:arr[0]];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)requestFinish:(id)responseObject
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"mainPicUrl"]] placeholderImage:kNoPicture];
    _lab1.text = [NSString stringWithFormat:@"产地：%@",responseObject[@"productionAddr"]];
    _lab2.text = [NSString stringWithFormat:@"产品规格/容量：%@", responseObject[@"modelDesc"]];
    _lab3.text = [NSString stringWithFormat:@"主要原料：%@", responseObject[@"elements"]];
    _lab4.text = responseObject[@"describe"];
}

@end
