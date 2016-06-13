//
//  HBSCTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 12/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

typedef void(^MoreDataBlock)(void);

@interface HBSCTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *names;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *xianjiaLabs;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *yuanjiaLabs;
@property (strong, nonatomic) IBOutlet UILabel *hLab;
@property (strong, nonatomic) IBOutlet UILabel *mLab;
@property (strong, nonatomic) IBOutlet UILabel *sLab;

@property (copy, nonatomic) MoreDataBlock moreDataBlock;
@property (nonatomic, strong) NSTimer *time;

- (void)setModel:(NSDictionary *)model;

@end
