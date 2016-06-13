//
//  SZHSDDTableViewCell.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/19.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SZHSDDTableViewCell.h"
#import "UtilsHeader.h"

@implementation SZHSDDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCell:(id)model
{
    /*
     {
     "maxPrice": 124,
     "_id": "573599e5c1babb3039a9adc3",
     "number": "1463130597358",
     "createTime": "2016-05-13 17:09:57",
     "name": "大家圣诞节",
     "price": 124,
     "index": 125,
     "picUrl": "http://7xi6ys.com1.z0.glb.clouddn.com/FpVo8FblnpBQaldssCYb3TiyeZ_b",
     "__v": 0,
     "lastUpdateTime": "2016-05-13 17:10:16"
     }
     */
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model[@"picUrl"]] placeholderImage:kNoPicture];
    [_batteryNameLabel setText:model[@"name"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
