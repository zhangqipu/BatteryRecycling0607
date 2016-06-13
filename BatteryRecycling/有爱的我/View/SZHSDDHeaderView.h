//
//  SZHSDDHeaderView.h
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/20.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SZHSDDButtonActionBlock)();

@interface SZHSDDHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *szhsddButton;
@property (nonatomic, strong) SZHSDDButtonActionBlock SZHSDDButtonActionBlock;

@end
