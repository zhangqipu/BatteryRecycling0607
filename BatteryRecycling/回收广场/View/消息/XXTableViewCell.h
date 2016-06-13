//
//  XXTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

- (void)setModel:(NSDictionary *)model;
@end
