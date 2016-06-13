//
//  TableViewFootView.h
//  BatteryRecycling
//
//  Created by jiasha.huang on 15/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MoreBlock)(UIButton *);
typedef void(^PostBlock)(void);

@interface TableViewFootView : UIView
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@property (nonatomic, copy) MoreBlock moreBlock;
@property (nonatomic, copy) PostBlock postBlock;

@end
