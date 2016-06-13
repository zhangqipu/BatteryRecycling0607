//
//  PageViewController.m
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/3.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self commonInit];
}

- (void)commonInit
{
    [self setupViewControllers];
    
    NSDictionary *options          = @{UIPageViewControllerOptionSpineLocationKey:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone]};
    
    _pageViewController            = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.delegate   = self;
    _pageViewController.dataSource = self;
    
    // 设置首先要显示的控制器
    [_pageViewController setViewControllers:@[_viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:_pageViewController.view];
    
    
}

- (void)setupViewControllers
{
    // 设置所有ViewControllers
    UIViewController *v1    = [UIViewController new];
    UIViewController *v2    = [UIViewController new];
    UIViewController *v3    = [UIViewController new];
    
    v1.view.backgroundColor = [UIColor redColor];
    v2.view.backgroundColor = [UIColor greenColor];
    v3.view.backgroundColor = [UIColor blueColor];
    
    _viewControllers        = @[v1, v2, v3];
}

#pragma mark
#pragma mark PageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    index--;
    
    if (index < 0) {
        return nil;
    }
    
    return self.viewControllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    index++;
    
    if (index >= self.viewControllers.count) {
        return nil;
    }
    
    return self.viewControllers[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//
//    
////    NSLog(@"%@", self.pageViewController);
////    NSLog(@"%@", NSStringFromClass([touch.view class]));
////    if ([[touch.view class] isSubclassOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
////        gestureRecognizer.enabled = NO;
////        return NO;
////    }
//    for (UIView *subView in self.pageViewController.view.subviews) {
//        if ([subView isKindOfClass:[UITableViewCell class]] || [subView isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
//            if( CGRectContainsPoint(self.pageViewController.view.frame, [gestureRecognizer locationInView:subView])){
//                return NO;
//            }
//        }
//    }
//    
//    return YES;
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    for (UIView *subView in self.pageViewController.view.subviews) {
//        if ([subView isKindOfClass:[UITableViewCell class]] || [subView isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
//            if( CGRectContainsPoint(self.pageViewController.view.frame, [gestureRecognizer locationInView:subView])){
//                return NO;
//            }
//        }
//    }
//}

@end
