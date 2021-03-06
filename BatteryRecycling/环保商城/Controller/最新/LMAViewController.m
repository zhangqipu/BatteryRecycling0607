//
//  LMAViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 12/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "LMAViewController.h"
#import "LMAMRViewController.h"
#import "PageHeaderView.h"

@interface LMAViewController ()

@property (nonatomic, strong) PageHeaderView *headerView;

@end

@implementation LMAViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最新";
    
    [self initSuberView];
}

- (void)initSuberView
{
    _headerView = LOADNibName(@"PageHeaderView");
    _headerView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 50);
    
    kWeekSelf
    _headerView.headerAction = ^(UIButton *sender){
        
        [weakSelf headerAction:sender];
    };
    [self.view addSubview:_headerView];
    
}

- (void)setupViewControllers
{
//    [NSString stringWithFormat:@"%@?token=%@",kGoodsCategory, StandardUserDefautsGet(@"token")]
//    ,@"filter":@[@{@"property":@"_id",@"value":@"类目A"}]
    
    NSString *filter1 = @"filter=[{\"property\":\"categoryName\",\"value\":\"类目A\"},{\"property\":\"categoryName\",\"value\":\"默认\"}]";
    NSString *url1 = [[NSString stringWithFormat:@"%@?token=%@&%@", kGoods, StandardUserDefautsGet(@"token"), @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    LMAMRViewController *vc1 = [[LMAMRViewController alloc] initWithUrl:url1 andParams: nil];
    vc1.nav = self.navigationController;
    
    LMAMRViewController *vc2 = [[LMAMRViewController alloc] initWithUrl: kGoods andParams:@{@"token":StandardUserDefautsGet(@"token")}];
    vc2.nav = self.navigationController;
    
    LMAMRViewController *vc3 = [[LMAMRViewController alloc] initWithUrl: kGoods andParams:@{@"token":StandardUserDefautsGet(@"token")}];
    vc3.nav = self.navigationController;
    
    LMAMRViewController *vc4 = [[LMAMRViewController alloc] initWithUrl: kGoods andParams:@{@"token":StandardUserDefautsGet(@"token")}];
    vc4.nav = self.navigationController;
    
    self.viewControllers        = @[vc1, vc2, vc3, vc4];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSUInteger index = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
    
    for (UIButton *btn in _headerView.subviews) {
        btn.selected = NO;
    }
    
    UIButton *btn = _headerView.subviews[index];
    btn.selected = YES;
}

- (void)headerAction:(UIButton *)sender {
    
    for (UIButton *btn in _headerView.subviews) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [self.pageViewController setViewControllers:@[self.viewControllers[sender.tag - 1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
