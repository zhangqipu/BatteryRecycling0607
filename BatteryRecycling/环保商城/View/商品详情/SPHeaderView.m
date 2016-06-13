//
//  SPHeaderView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SPHeaderView.h"
#import "UtilsHeader.h"

@implementation SPHeaderView

- (void)awakeFromNib
{
    
}

- (void)setModel:(NSDictionary *)dic
{
    _nameLab.text = dic[@"name"];
    _xianjiaLab.text = [NSString stringWithFormat:@"￥%@", dic[@"showPrice"]];
    _yuanjiaLab.attributedText = [ToolsObj setAttributedString:[NSString stringWithFormat:@"￥%@", dic[@"showMarketPrice"]]];
    
    _pinpaiLab.text = dic[@"brand"];
    _xiaoliangLab.text = [NSString stringWithFormat:@"%@", dic[@"saleCount"]];
    _xihuanLab.text = [NSString stringWithFormat:@"喜欢:%@人",dic[@"likeCount"]];
    NSArray *models = dic[@"models"];
    _yunfeiLab.text = [NSString stringWithFormat:@"￥%@元",  models[0][@"postage"]];
    _shangxianLab.text = [NSString stringWithFormat:@"%@", models[0][@"maxHBBAble"]];
}

@end
