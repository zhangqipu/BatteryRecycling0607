//
//  GWCTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilsHeader.h"

typedef void(^XuanZhongBlock)(UIButton *);
typedef void(^NumBlock)(NSInteger);

@interface GWCTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *xuanzhongBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UIButton *jianBtn;
@property (strong, nonatomic) IBOutlet UIButton *jiaBtn;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *jiageLab;
@property (strong, nonatomic) IBOutlet UITextField *numText;

@property (strong, nonatomic) NSDictionary *model;
@property (copy, nonatomic) XuanZhongBlock xuanZhongBlock;
@property (copy, nonatomic) NumBlock numBlock;


- (void)setModel:(NSDictionary *)model;

- (void)setDeleteModel:(NSDictionary *)model;

@end
