//
//  RegTwoViewController.h
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"
#import "HudViewController.h"

@interface RegTwoViewController : HudViewController
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UITextField *adrText;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *passWord;

@end
