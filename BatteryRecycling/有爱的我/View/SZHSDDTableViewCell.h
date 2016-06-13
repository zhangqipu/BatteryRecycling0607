//
//  SZHSDDTableViewCell.h
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/19.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZHSDDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *batteryNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

/**
 *  配置cell数据
 *
 *  @param model 模型数据
 */
- (void)configCell:(id)model;

@end
