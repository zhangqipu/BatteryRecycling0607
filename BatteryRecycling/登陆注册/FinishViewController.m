//
//  RegFinishViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "FinishViewController.h"
#import "UtilsHeader.h"
#import "GRZIViewController.h"

@interface FinishViewController ()

@end

@implementation FinishViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);

}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = _navTitle;
    
    _lab1.text = _str1;
    _lab2.text = _str2;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishItemAtion)];
    item.tintColor = UIColorFromRGB(0xffffff);
    self.navigationItem.rightBarButtonItem = item;
}

- (void)finishItemAtion
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
