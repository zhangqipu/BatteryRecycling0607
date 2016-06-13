//
//  DZGLTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

typedef void(^DeleteAdrBlock)(void);

@interface DZGLTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *phoneLab;
@property (strong, nonatomic) IBOutlet UILabel *adrLab;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;

@property (strong, nonatomic) NSDictionary *model;

@property (copy, nonatomic) DeleteAdrBlock deleteAdr;

- (void)setModel:(NSDictionary *)model;

@end
