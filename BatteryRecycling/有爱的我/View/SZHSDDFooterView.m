//
//  SZHSDDFooterView.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/20.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SZHSDDFooterView.h"

@implementation SZHSDDFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)saveButtonAction:(id)sender {
    if (_saveSettedPriceBlock) {
        _saveSettedPriceBlock();
    }
}

@end
