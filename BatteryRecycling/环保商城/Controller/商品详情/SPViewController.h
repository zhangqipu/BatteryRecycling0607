//
//  SPViewController.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^ShangPinBlock)(NSDictionary *);

@interface SPViewController : BaseTableViewController

@property (nonatomic, copy) ShangPinBlock shangPinBlock;

@end
