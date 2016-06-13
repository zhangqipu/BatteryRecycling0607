//
//  XSQGHeader.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 13/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSQGHeader : UIView

@property (strong, nonatomic) IBOutlet UILabel *hLab;
@property (strong, nonatomic) IBOutlet UILabel *mLab;
@property (strong, nonatomic) IBOutlet UILabel *sLab;

@property (nonatomic, strong) NSTimer *time;


@end
