//
//  SPXQFootView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LiJiGouMaiBlock)(void);

@interface SPXQFootView : UIView

@property (strong, nonatomic) IBOutlet UILabel *shoucangLab;
@property (strong, nonatomic) IBOutlet UILabel *xihuanLab;
@property (strong, nonatomic) IBOutlet UILabel *gouwucheLab;
@property (strong, nonatomic) IBOutlet UIButton *shouchangBtn;
@property (strong, nonatomic) IBOutlet UIButton *xihuanBtn;
@property (strong, nonatomic) IBOutlet UILabel *numLab;

@property (strong, nonatomic) NSDictionary *model;
@property (copy, nonatomic) LiJiGouMaiBlock liJiGouMaiBlock;

- (void)setModel:(NSDictionary *)model;

@end
