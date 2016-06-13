//
//  ZHMMOneViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptchaView.h"
#import "HudViewController.h"

@interface ZHMMOneViewController : HudViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (strong, nonatomic) CaptchaView *captchaView;

@end
