//
//  CALayer+ColorEx.m
//  AshineDoctor
//
//  Created by JiangYue on 15/2/27.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "CALayer+ColorEx.h"

@implementation CALayer (ColorEx)

- (void)setBorderColorEx:(UIColor *)uiColor
{
    self.borderColor = uiColor.CGColor;
}


@end
