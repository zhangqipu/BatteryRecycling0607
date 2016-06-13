//
//  SCSPTableViewCell.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "SCSPTableViewCell.h"

@implementation SCSPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configCell:(id)model
{
    /*
     {
     "_id": "56f9f8aac4dd15c01ec4b492",
     "createTime": "2016-03-29 11:38:18",
     "userId": "56f8aa4a13366a381c77b7c2",
     "goodsId": "56f9e86d66fbe1101fe1909a",
     "title": "营养快线4号",
     "model": "750ml;1500ml",
     "price": 7,
     "marketPrice": 7.5,
     "mainPicUrl": "http://7xi6ys.com1.z0.glb.clouddn.com/Fj2_0yCyvcCUyTH0Otaj61OcVtIp",
     "__v": 0
     }
     */
    
    [_goodImageView sd_setImageWithURL:
     [NSURL URLWithString:model[@"mainPicUrl"]] placeholderImage:kNoPicture];
    [_goodDescLabel setText:model[@"title"]];
    [_numLabel setText:[NSString stringWithFormat:@"规格/容量 %@", model[@"model"]]];
    [_amountLabel setText:[NSString stringWithFormat:@"￥%@元", [model[@"price"] stringValue]]];
    [_amountLabel setText:[NSString stringWithFormat:@"￥%@元", [model[@"marketPrice"] stringValue]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
