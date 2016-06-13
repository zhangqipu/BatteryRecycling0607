//
//  FBDDTableViewCell2.m
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/19.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "FBDDTableViewCell2.h"

@implementation FBDDTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCell:(id)model
{
    /*
     {
     "_id": "56fa70ad28aa72f020cb077c",
     "publisherNo": "10005",
     "publisherName": "Uncle.Zhang",
     "publisherPhone": "18682416186",
     "state": "交易成功",
     "number": "1459253421106",
     "createTime": "2016-03-29 20:10:21",
     "publisherId": "56f8d1282b04b8001d3bedf9",
     "province": "广东省",
     "city": "深圳市",
     "area": "宝安区",
     "address": "万骏经贸大厦",
     "__v": 0,
     "amount": 60.93,
     "reclaimerId": "56fa72e0e389a21fe7cf841f",
     "reclaimerName": "Uncle.Zhang_shuai2",
     "reclaimerPhone": "18682416187",
     "reclaimerArea": "深圳市宝安区",
     "assignTime": "2016-03-30 12:10:30",
     "lastUpdateTime": "2016-03-30 12:10:52",
     "processTime": "2016-03-30 11:59:00",
     "processRemark": "无法进行了",
     "ignoreUsers": {
     "undefined": true
     },
     "detail": [
     {
     "price": 0.99,
     "brNumber": "1459160291585",
     "brName": "1号电池加强版",
     "qty": 3
     },
     {
     "price": 28.98,
     "brNumber": "1459160303775",
     "brName": "2号电池",
     "qty": 2
     }
     ]
     }
     */
    
    [_orderIdLabel setText:model[@"_id"]];
    [_stateLabel setText:model[@"state"]];
    
    NSArray *batteryInfoArray = model[@"detail"];
    
    for (int i = 0; i < batteryInfoArray.count; i++) {
        NSDictionary *batteryInfo = batteryInfoArray[i];
        UILabel *batteryNameLabel = _batteryNameLabels[i];
        UILabel *batteryPriceLabel = _batteryPriceLabels[i];
        UILabel *batteryCountLabel = _batteryCountLabels[i];
        UILabel *batteryAmountLabel = _batteryAmountLabels[i];
        
        [batteryNameLabel setText:batteryInfo[@"brName"]];
        [batteryPriceLabel setText:[NSString stringWithFormat:@"单价:%@元", [batteryInfo[@"price"] stringValue]]];
        [batteryCountLabel setText:[NSString stringWithFormat:@"数量X%@", [batteryInfo[@"qty"] stringValue]]];
        
        float totalPrice = [batteryInfo[@"price"] floatValue] * [batteryInfo[@"qty"] floatValue];
        [batteryAmountLabel setText:[NSString stringWithFormat:@"小计:%.2f", totalPrice]];
    }
    
    [_createTimeLabel setText:model[@"createTime"]];
    [_totalAmountLabel setText:[NSString stringWithFormat:@"￥:%@", model[@"amount"]]];
    [_HHSNameLabel setText:[NSString stringWithFormat:@"%@", model[@"reclaimerName"]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
