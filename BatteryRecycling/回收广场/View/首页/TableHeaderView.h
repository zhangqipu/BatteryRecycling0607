//
//  TableHeaderView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView
@property (strong, nonatomic) IBOutlet UILabel *lab1;
@property (strong, nonatomic) IBOutlet UILabel *lab2;
@property (strong, nonatomic) IBOutlet UILabel *lab3;
@property (strong, nonatomic) IBOutlet UILabel *lab4;
@property (strong, nonatomic) IBOutlet UIButton *adrBtn;

- (void)setModel:(NSDictionary *)model;
@end
