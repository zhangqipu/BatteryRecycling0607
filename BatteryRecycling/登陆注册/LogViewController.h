//
//  LogViewController.h
//  BatteryRecycling
//
//  Created by 健库 on 16/3/31.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"
#import "HudViewController.h"

@interface LogViewController : HudViewController

@property (weak ,nonatomic) IBOutlet UITextField * account;
@property (weak ,nonatomic) IBOutlet UITextField * password;

@end
