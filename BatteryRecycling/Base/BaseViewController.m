//
//  BaseViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "BaseViewController.h"
#import "UtilsHeader.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xffffff)];
    
    self.navigationController.navigationBar.titleTextAttributes =@{NSForegroundColorAttributeName:[UIColor whiteColor]};
     
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self showNavBackItem:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNavBackItem:(BOOL)isShow
{
    if (isShow == YES) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui1"] style:UIBarButtonItemStylePlain target:self action:@selector(navBackAction)];
    }
}

- (void)navBackAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}


@end
