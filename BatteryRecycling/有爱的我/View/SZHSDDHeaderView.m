//
//  SZHSDDHeaderView.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/20.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SZHSDDHeaderView.h"

@implementation SZHSDDHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)hsdqButtonAction:(id)sender {
    if (_SZHSDDButtonActionBlock) {
        _SZHSDDButtonActionBlock();
    }
}

@end
