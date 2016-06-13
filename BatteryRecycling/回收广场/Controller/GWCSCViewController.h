//
//  GWCSCViewController.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^DeleteIndexSetBlock) (NSMutableIndexSet *);

@interface GWCSCViewController : BaseTableViewController

@property (nonatomic, copy) DeleteIndexSetBlock deleteIndexSet;

@end
