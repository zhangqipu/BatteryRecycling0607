//
//  XXTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XXTableViewCell.h"

@implementation XXTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(NSDictionary *)model
{
    _textLab.text = model[@"content"];
    _timeLab.text = model[@"createTime"];
}

@end
