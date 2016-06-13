//
//  HBSCNavView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 17/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MessageBlock)(void);
typedef void(^GWCBlock)(void);

@interface HBSCNavView : UIView

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *gwcNumLab;

@property (copy, nonatomic) MessageBlock messageBlock;

@property (copy, nonatomic) GWCBlock gWCBlock;

@end
