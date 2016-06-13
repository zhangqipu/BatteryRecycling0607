//
//  GWCFootView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QuanXuanBlock)(UIButton *);

@interface GWCFootView : UIView

@property (strong, nonatomic) IBOutlet UILabel *subLab;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;
@property (strong, nonatomic) IBOutlet UIButton *quanxuanBtn;

@property (copy, nonatomic) QuanXuanBlock quanXuanBlock;

@end
