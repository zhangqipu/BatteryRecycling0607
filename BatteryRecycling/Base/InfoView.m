//
//  InfoView.m
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/26.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

- (void)setType:(InfoType)type
{
    _type = type;
//    NSString *imgName = nil;
    
    switch (type) {
        case InfoTypeSucceed:
//            imgName = @"action_success";
            break;
            
        case InfoTypeFailed:
//            imgName = @"action_fail";
            break;
        case InfoTypeWarning:
//            imgName = @"";
            break;
            
        default:
            break;
    }
    
//    _typeImageView.image = [UIImage imageNamed:imgName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
