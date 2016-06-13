//
//  YADWHeaderView.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditDataBlock)(void);
typedef void(^OrderBlock)(NSInteger);

@interface YADWHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *logHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *userIDlAB;

@property (nonatomic, copy) EditDataBlock editDataBlock;
@property (nonatomic, copy) OrderBlock orderBlock;

@end
