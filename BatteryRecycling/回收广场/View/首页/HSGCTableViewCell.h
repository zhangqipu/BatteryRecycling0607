//
//  HSGCTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 11/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

@interface HSGCTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *upLab;
@property (strong, nonatomic) IBOutlet UILabel *donwLab;
@property (strong, nonatomic) IBOutlet UITextField *text;

- (void)configCell:(id)model;

@end
