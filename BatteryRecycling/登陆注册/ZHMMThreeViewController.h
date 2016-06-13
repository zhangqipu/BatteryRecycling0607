//
//  ZHMMThreeViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"
#import "HudViewController.h"

@interface ZHMMThreeViewController : HudViewController
@property (weak, nonatomic) IBOutlet UITextField *passWordText1;
@property (weak, nonatomic) IBOutlet UITextField *passWordText2;
@property (nonatomic, strong) NSString *phone;

@end
