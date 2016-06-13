//
//  InfoView.h
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/26.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InfoType) {
    InfoTypeSucceed = 0,
    InfoTypeWarning,
    InfoTypeFailed
};

@interface InfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (assign, nonatomic) InfoType type;

@end
