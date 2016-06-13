//
//  HSGCViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudViewController.h"

@interface HSGCViewController :HudViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tebleView;

@property (strong, nonatomic) IBOutlet UILabel *gwcNumLab;
@end
