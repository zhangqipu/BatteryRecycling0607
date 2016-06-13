//
//  PageViewController.h
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/3.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "BaseViewController.h"
#import "HudViewController.h"

@interface PageViewController : HudViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *viewControllers;

- (void)setupViewControllers;

@end
