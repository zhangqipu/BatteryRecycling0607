//
//  GWCSCFootView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DeleteBlock)(UIButton *);
typedef void (^DeleteAllBlock)(void);

@interface GWCSCFootView : UIView

@property (nonatomic, copy) DeleteBlock deleteBlock;
@property (nonatomic, copy) DeleteAllBlock deleteAllBlock;

@end
