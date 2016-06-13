//
//  SPPJTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SPPJTableViewCell.h"

@implementation SPPJTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NSDictionary *)model
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model[@"picUrl"]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _nameLab.text = model[@"name"];
    _commentLab.text = model[@"content"];
    _buyTime.text = [NSString stringWithFormat:@"购买时间：%@", model[@"buyTime"]];
    _time.text = model[@"time"];
}

@end
