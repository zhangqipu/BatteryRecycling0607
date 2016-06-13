//
//  HudViewController.h
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/4.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "BaseViewController.h"
#import "UtilsHeader.h"
#import "InfoView.h"


@interface HudViewController : BaseViewController

// 显示loading
- (void)showLoadingView;
- (void)hideLoadingView;

// 显示创建indicator
- (void)showIndicatorView;
- (void)hideIndicatorView;

// 在Window上显示Loading
- (void)showLoadingViewOnWindow;
- (void)hideLoadingViewFromWindow;

// 显示提示信息自动消失
- (void)showInfoView:(NSString *)info infoType:(InfoType)type;

@end
