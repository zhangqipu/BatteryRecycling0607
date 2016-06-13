//
//  TableViewFootView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "TableViewFootView.h"

@implementation TableViewFootView
- (void)awakeFromNib
{

}

- (IBAction)moreAction:(UIButton *)sender {
    _moreBlock(sender);
}

- (IBAction)postAction:(UIButton *)sender {
    _postBlock();
}

@end
