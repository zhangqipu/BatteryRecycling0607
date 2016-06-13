//
//  LogOutHeaderView.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "LogOutHeaderView.h"

@implementation LogOutHeaderView

- (void)awakeFromNib{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLoginAction)];
    [_headerImageView addGestureRecognizer:tap];
}

- (IBAction)loginAction:(UIButton *)sender {
    
    self.pushBlock();
    
}

- (void)pushLoginAction
{
    self.pushBlock();
}

@end
