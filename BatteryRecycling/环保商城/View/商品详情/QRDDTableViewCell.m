//
//  QRDDTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 19/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "QRDDTableViewCell.h"
#import "UtilsHeader.h"

@implementation QRDDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NSDictionary *)model
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model[@"mainPicUrl"]] placeholderImage:kNoPicture];
    _namelab.text = model[@"name"];
    _guigeLab.text = model[@"modelDesc"];
    _shuliangLab.text = [NSString stringWithFormat:@"数量：x%@节", _num];
    _priceLab.text = [NSString stringWithFormat:@"￥%@元", model[@"showPrice"]];
    NSString *kuaidi = [NSString stringWithFormat:@"%@",model[@"models"][0][@"postage"]];
    if ([kuaidi integerValue] == 0) {
        _kuaidiLab.text = @"快递 免邮";

    } else {
        _kuaidiLab.text = [NSString stringWithFormat:@"快递:%@元",kuaidi];
    }
    
    
}
@end
