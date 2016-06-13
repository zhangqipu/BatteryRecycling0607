//
//  SPPJTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

@interface SPPJTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *commentLab;
@property (strong, nonatomic) IBOutlet UILabel *buyTime;
@property (strong, nonatomic) IBOutlet UILabel *time;

- (void)setModel:(NSDictionary *)model;
@end
