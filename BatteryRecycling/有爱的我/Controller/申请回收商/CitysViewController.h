//
//  CitysViewController.h
//  SchoolApp
//
//  Created by 黄嘉沙 on 15/10/26.
//  Copyright (c) 2015年 张齐朴. All rights reserved.
//

#import "BaseViewController.h"
#import "UtilsHeader.h"

typedef void(^CityBlock)(NSString *, NSString *, NSString *, NSString *);

@interface CitysViewController : BaseViewController
@property (strong, nonatomic) UILabel *areaText;
@property (strong, nonatomic) NSDictionary *citys;

@property (copy, nonatomic) CityBlock cityBlock;

@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *area;

@end
