//
//  TKTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "TKTableViewCell.h"

@implementation TKTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configCell:(id)model
{
    /*
     {
     "_id": "56fc8c1fd51b94e011c62005",
     "state": "关闭",
     "number": "O1459391519261",
     "createTime": "2016-04-31 23:31:59",
     "totalQty": 5,
     "deliveryAmount": 10,
     "totalAmount": 23,
     "isUsedHBB": true,
     "HBBAmount": 10,
     "receiver": "张亮帅",
     "receiverPhone": "18682416187",
     "receiverProvince": "广东省",
     "receiverCity": "深圳市",
     "receiverArea": "宝安区",
     "receiverAddr": "万骏经贸大厦",
     "buyerId": "56f8d1282b04b8001d3bedf9",
     "buyerName": "Uncle.Zhang",
     "buyerPhone": "18682416186",
     "__v": 0,
     "lastUpdateTime": "2016-05-01 23:52:20.595",
     "expressCorp": "天天快递",
     "expressNo": "TT0012",
     "paymentMode": "WXPAY",
     "thirdAmount": 13,
     "walletAmount": 10,
     "thirdPayOrderNo": "3C3DE2169DC8D71364F6C1689E874E41",
     "paymentState": "ToPay",
     "goodsList": [
     {
     "goodsId": "56fb8453d860b340050c7123",
     "number": "G1459323987144",
     "name": "营养快线",
     "mainPicUrl": "http://7xi6ys.com1.z0.glb.clouddn.com/Fj2_0yCyvcCUyTH0Otaj61OcVtIp",
     "model": "500ml",
     "price": 4.2,
     "qty": 3,
     "postage": 10,
     "maxHBBAble": 4
     },
     {
     "goodsId": "56fb846dd860b340050c7124",
     "number": "G1459324013622",
     "name": "营养快线2",
     "mainPicUrl": "http://7xi6ys.com1.z0.glb.clouddn.com/Fj2_0yCyvcCUyTH0Otaj61OcVtIp",
     "model": "500ml",
     "price": 5.2,
     "qty": 2,
     "postage": 0,
     "maxHBBAble": 5
     }
     ]
     }
     
     */
    
    // 取第一件商品
    NSDictionary *firstGood = model[@"goodsList"][0];
    
    [_idLabel setText:[NSString stringWithFormat:@"订单号: %@", model[@"number"]]];
    [_goodImageView sd_setImageWithURL:
     [NSURL URLWithString:firstGood[@"mainPicUrl"]] placeholderImage:kNoPicture];
    [_goodDescLabel setText:firstGood[@"name"]];
    [_numLabel setText:[NSString stringWithFormat:@"%@", firstGood[@"model"]]];
    [_orderTimeLabel setText:[NSString stringWithFormat:@"下单时间: %@", model[@"createTime"]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
