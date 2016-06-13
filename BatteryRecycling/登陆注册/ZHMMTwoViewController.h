//
//  ZHMMTwoViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"
#import "HudViewController.h"

@interface ZHMMTwoViewController : HudViewController

@property (nonatomic, strong) NSString *userName;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UITextField *codeText;
@property (strong, nonatomic) IBOutlet UILabel *lab;

@property (strong, nonatomic) NSString *code;

@end
