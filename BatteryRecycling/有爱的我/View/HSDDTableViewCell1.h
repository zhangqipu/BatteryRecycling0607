//
//  HSDDTableViewCell1.h
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/19.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSDDTableViewCell1 : UITableViewCell

// 订单ID
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
// 状态
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
// 电池头像
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *headerImageVeiws;
// 电池名称
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *batteryNameLabels;
// 电池单价
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *batteryPriceLabels;
// 电池数量
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *batteryCountLabels;
// 电池总价
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *batteryAmountLabels;
// 创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
// 订单总价
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
// 回收商名称
@property (weak, nonatomic) IBOutlet UILabel *HHSNameLabel;

/**
 *  配置cell数据
 *
 *  @param model 模型数据
 */
- (void)configCell:(id)model;

@end
