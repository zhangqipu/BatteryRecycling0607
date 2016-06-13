//
//  LogOutHeaderView.h
//  BatteryRecycling
//
//  Created by manyu on 16/5/2.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PushLoginBlock)(void);

@interface LogOutHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (copy, nonatomic) PushLoginBlock pushBlock;

@end
