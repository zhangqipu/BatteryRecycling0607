//
//  WDAXSJViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "WDAXSJViewController.h"

@interface WDAXSJViewController ()

@end

@implementation WDAXSJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的爱心数据";
    [self requestLoveData];
}

- (void)requestLoveData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:[NSString stringWithFormat:@"%@?token=%@&operatorId=%@",kLoveData, StandardUserDefautsGet(@"token"), StandardUserDefautsGet(@"user")[@"_id"]]
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             if ([responseObject[@"success"] boolValue] == true) {
                 [self requestFnishLoveData:responseObject];
             }
             
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
         }];
}

- (void)requestFnishLoveData:(id)responseObject
{
    NSDictionary *model = responseObject[@"result"];
    NSString *str = [NSString stringWithFormat:@"%@", model[@"count"]];
    NSString *str1 = [NSString stringWithFormat:@"您是第 %@ 位加入我们的地球君", str];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:str1];
    
    NSRange contentRange = {4,[str length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19.0] range:contentRange];
    [content addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc5cb1a) range:contentRange];
    
    _lab.attributedText = content;
    
    _lab1.text = [NSString stringWithFormat:@"共回收电池:%@节", model[@"totalBrCount"]];
    
    _lab2.text = [NSString stringWithFormat:@"累计财富交易:%@元", model[@"totalAmount"]];
    
    double  totalArea = [model[@"totalArea"] doubleValue];

    _lab3.text = [NSString stringWithFormat:@"共维护地球:%.20f平方公顷",  totalArea];
}


@end
