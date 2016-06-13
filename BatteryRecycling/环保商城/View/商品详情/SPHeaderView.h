//
//  SPHeaderView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHeaderView : UIView

@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *xianjiaLab;
@property (strong, nonatomic) IBOutlet UILabel *yuanjiaLab;
@property (strong, nonatomic) IBOutlet UILabel *pinpaiLab;
@property (strong, nonatomic) IBOutlet UILabel *xiaoliangLab;
@property (strong, nonatomic) IBOutlet UILabel *yunfeiLab;
@property (strong, nonatomic) IBOutlet UILabel *shangxianLab;
@property (strong, nonatomic) IBOutlet UILabel *xihuanLab;

- (void)setModel:(NSDictionary *)dic;
@end
