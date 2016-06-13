//
//  LMATableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 12/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "LMATableViewCell.h"

@implementation LMATableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(NSDictionary *)model
{
    // 主图
    [_headerImageView sd_setImageWithURL:model[@"mainPicUrl"] placeholderImage:kNoPicture];
    
     NSArray *arr = model[@"models"];
    
    // 价格
    _presentPriceLab.text = [NSString stringWithFormat:@"￥%@元", arr[0][@"price"]];
    // 原价
    NSString *str = [NSString stringWithFormat:@"￥%@",arr[0][@"marketPrice"]];
    
    _originalPriceLab.attributedText = [ToolsObj setAttributedString:str];
    
    NSString *str1;
    if (model[@"saleCount"] == nil){
        str1 = @"0";
    }
    
    _textLab.text = [NSString stringWithFormat:@"收藏:%@人    销量:%@件", model[@"collectCount"], str1];
    
    _titleLab.text = model[@"name"];
    
}

@end
