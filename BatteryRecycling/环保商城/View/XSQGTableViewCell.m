//
//  XSQGTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 13/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XSQGTableViewCell.h"

@implementation XSQGTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(NSDictionary *)model
{
    // 主图
    [_headerImageView sd_setImageWithURL:model[@"picUrl"] placeholderImage:kNoPicture];
    
    // 价格
    _presentPriceLab.text = [NSString stringWithFormat:@"￥%@元", model[@"price"]];
    // 原价
    NSString *str = [NSString stringWithFormat:@"￥%@",model[@"marketPrice"]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    
    _originalPriceLab.attributedText = attributedString;
    
    _titleLab.text = model[@"name"];
    
    
    _discountLab.text = [NSString stringWithFormat:@"%@折",model[@"maxHBBAble"]];
}

@end
