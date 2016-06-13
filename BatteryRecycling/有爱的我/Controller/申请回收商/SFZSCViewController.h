//
//  SFZSCViewController.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 5/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "HudViewController.h"

typedef void (^FinishUpLoadImageBlock)(NSString *, NSString *);

@interface SFZSCViewController : HudViewController

@property (strong, nonatomic) IBOutlet UIImageView *iamgeView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;

@property (copy, nonatomic) FinishUpLoadImageBlock finishUpLoadImageBlock;

@end
