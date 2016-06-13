//
//  GWCSCFootView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "GWCSCFootView.h"

@implementation GWCSCFootView

- (void)awakeFromNib
{

}

- (IBAction)touchDeleteAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _deleteBlock(sender);
}


- (IBAction)postAllDeleteAction:(UIButton *)sender{
    
    _deleteAllBlock();
}

@end
