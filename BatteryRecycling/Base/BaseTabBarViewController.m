//
//  BaseTabBarViewController.m
//  BatteryRecycling
//
//  Created by 苹果 on 16/3/26.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "UtilsHeader.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *classNameArray = @[@"HSGCViewController",@"HBSCViewController",@"YADWViewController"];
    NSArray *titleArray = @[@"回收广场",@"环保商城",@"有爱的我"];
    NSMutableArray *navigationControllerArray = [[NSMutableArray alloc] init];
    NSArray * selImgArray = @[@"iconfont_huishou",@"icon_huanbao",@"icon_youai"];
    NSArray * imgArray = @[@"iconfont_huishou_N",@"icon_huanbao_N",@"icon_youai_N"];
    for (int i=0; i<classNameArray.count; i++) {
        UIViewController *viewController = [[NSClassFromString(classNameArray[i]) alloc] init];
        //设置title
        viewController.title = titleArray[i];
        //设置tabbarItem图片
        UIImage *normalImage = [UIImage imageNamed:imgArray[i]];
        UIImage *selectedImage = [UIImage imageNamed:selImgArray[i]];
        if (iOS7) {
            viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        else {
            [viewController.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationControllerArray addObject:navigationController];
    }
    self.viewControllers = navigationControllerArray;
    self.tabBar.barTintColor = UIColorFromRGB(0x000009);
    
    //设置UITabBarItem属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xA2A2A2), NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:10.0f]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(ThemeGreen), NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:10.0f]} forState:UIControlStateSelected];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
