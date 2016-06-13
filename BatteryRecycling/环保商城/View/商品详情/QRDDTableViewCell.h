//
//  QRDDTableViewCell.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 19/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRDDTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *namelab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *shuliangLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *kuaidiLab;
@property (strong, nonatomic) IBOutlet UITextField *liuyanText;
@property (strong, nonatomic) IBOutlet UILabel *pricesLab;

@property (strong, nonatomic) NSString *num;

- (void)setModel:(NSDictionary *)model;

@end
