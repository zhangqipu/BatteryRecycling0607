//
//  ZHAQViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 11/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "ZHAQViewController.h"
#import "XGDLMMViewController.h"
#import "XGZFMMViewController.h"

@interface ZHAQViewController ()

@end

@implementation ZHAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
}


/*
 * 修改登录密码
 */
- (IBAction)setLoginPassword:(UIButton *)sender {
    XGDLMMViewController *vc = [XGDLMMViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 * 修改支付密码
 */
- (IBAction)setPayPassword:(UIButton *)sender {
    XGZFMMViewController *vc = [XGZFMMViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
