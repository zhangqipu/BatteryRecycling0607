//
//  SPXQViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SPXQViewController.h"
#import "SPViewController.h"
#import "XQViewController.h"
#import "PJViewController.h"
#import "SPXQFootView.h"
#import "QRDDViewController.h"

@interface SPXQViewController ()

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) SPXQFootView *footView;

@end

@implementation SPXQViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"商品详情";
    [self initSuberView];
}

- (void)initSuberView
{
    _headerView = LOADNibName(@"SPXQHeaderView");
    _headerView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
    [self.view addSubview:_headerView];
    
    _footView = LOADNibName(@"SPXQFootView");
    _footView.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    kWeekSelf
    _footView.liJiGouMaiBlock = ^(){
        QRDDViewController *vc = [QRDDViewController new];
        NSMutableArray *arr = [NSMutableArray arrayWithObject:weakSelf.model];
        vc.models = arr;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:_footView];
}

- (void)setupViewControllers
{
    
/*
 * 商品
 */
    NSString *filter1 = [NSString stringWithFormat:@"filter=[{\"property\":\"_id\",\"value\":\"%@\"}]", _goodsId];
    NSString *url1 = [[NSString stringWithFormat:@"%@?token=%@&%@",kGoods, StandardUserDefautsGet(@"token"), filter1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    SPViewController *vc1 = [[SPViewController alloc] initWithUrl:url1 andParams:nil];
    vc1.shangPinBlock = ^(NSDictionary *model){
        [_footView setModel:model];
         _model = model;
    };
/*
 * 详情
 */
    XQViewController *vc2 = [[XQViewController alloc] init];
    vc2.goodsId = _goodsId;
  
/*
 * 评价
 */
    NSString *filter3 = [NSString stringWithFormat:@"filter=[{\"property\":\"_id\",\"value\":\"%@\"}]", _goodsId];
    NSString *url3 = [[NSString stringWithFormat:@"%@?token=%@&%@",kComment, StandardUserDefautsGet(@"token"), @""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    PJViewController *vc3 = [[PJViewController alloc] initWithUrl:url3 andParams:nil];
    
    self.viewControllers = @[vc1, vc2, vc3];
    
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


- (IBAction)headerAction:(UIButton *)sender {
    
    for (UIButton *btn in _headerView.subviews) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [self.pageViewController setViewControllers:@[self.viewControllers[sender.tag - 1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
