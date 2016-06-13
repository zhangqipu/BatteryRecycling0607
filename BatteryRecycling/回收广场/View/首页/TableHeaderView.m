//
//  TableHeaderView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "TableHeaderView.h"
#import "UtilsHeader.h"

@implementation TableHeaderView

- (void)awakeFromNib
{

}

- (void)setModel:(NSDictionary *)model
{
    NSString *str = [NSString stringWithFormat:@"%@", model[@"count"]];
    NSString *str1 = [NSString stringWithFormat:@"%@ 位加入我们的地球君", str];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:str1];
    
    NSRange contentRange = {0,[str length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19.0] range:contentRange];
    [content addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc5cb1a) range:contentRange];
    
    _lab1.attributedText = content;
    
    _lab2.text = [NSString stringWithFormat:@"共回收电池:%@节", model[@"totalBrCount"]];
    
    _lab3.text = [NSString stringWithFormat:@"累计财富交易:%@元", model[@"totalAmount"]];
    
    double  totalArea = [model[@"totalArea"] doubleValue];
    
    _lab4.text = [NSString stringWithFormat:@"共维护地球:%.20f平方公顷",  totalArea];

}

@end
