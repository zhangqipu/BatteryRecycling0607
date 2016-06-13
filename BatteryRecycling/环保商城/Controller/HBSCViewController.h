//
//  HBSCViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SDCycleScrollView.h"
#import "XXViewController.h"
#import "GWCViewController.h"

@interface HBSCViewController : BaseTableViewController

@property (strong, nonatomic) NSMutableArray *banners;

@property (strong, nonatomic) SDCycleScrollView *scrollView;

@end
