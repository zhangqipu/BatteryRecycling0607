//
//  LMATableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 12/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

@interface LMATableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *textLab;
@property (strong, nonatomic) IBOutlet UILabel *originalPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *presentPriceLab;

- (void)setModel:(NSDictionary *)model;

@end
