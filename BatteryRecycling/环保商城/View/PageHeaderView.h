//
//  PageHeaderView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 21/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderAction)(UIButton *);

@interface PageHeaderView : UIView

@property (copy , nonatomic) HeaderAction headerAction;

@end
