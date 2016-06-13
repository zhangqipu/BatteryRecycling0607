//
//  SZHSDDFooterView.h
//  BatteryRecycling
//
//  Created by 张齐朴 on 16/5/20.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SaveSettedPriceBlock) ();

@interface SZHSDDFooterView : UIView

@property (copy, nonatomic) SaveSettedPriceBlock saveSettedPriceBlock;

@end
