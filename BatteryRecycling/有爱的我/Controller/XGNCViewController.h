//
//  XGNCViewController.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 10/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "HudViewController.h"
#import "UtilsHeader.h"

typedef void(^FinishEditBlock)(NSString *name);

@interface XGNCViewController : HudViewController
@property (strong, nonatomic) IBOutlet UITextField *text;

@property (copy, nonatomic) FinishEditBlock finishEdit;
@end
