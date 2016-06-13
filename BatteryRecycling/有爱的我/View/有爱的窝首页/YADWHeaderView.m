//
//  YADWHeaderView.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "YADWHeaderView.h"

@implementation YADWHeaderView

- (void)awakeFromNib
{
}

- (IBAction)OrderAction:(UIButton *)sender {
    _orderBlock(sender.tag);
}

- (IBAction)editAction:(UIButton *)sender {
    
    _editDataBlock();
    
}


@end
