//
//  DFKTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

typedef void(^DeleteOrderBlock)(void);
typedef void(^ToPayBlock)(void);

@interface DFKTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (copy, nonatomic) DeleteOrderBlock deleteOrderBlock;
@property (copy, nonatomic) ToPayBlock toPayBlock;

/**
 *  配置cell数据
 *
 *  @param model 模型数据
 */
- (void)configCell:(id)model;

@end
