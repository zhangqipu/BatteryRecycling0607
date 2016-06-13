//
//  XSQGTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 13/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"



@interface XSQGTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *discountLab;
@property (strong, nonatomic) IBOutlet UILabel *originalPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *presentPriceLab;

- (void)setModel:(NSDictionary *)model;

@end
