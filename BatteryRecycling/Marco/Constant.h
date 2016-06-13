//
//  Constant.h
//  BaoluoGamePlatform
//
//  Created by 张齐朴 on 16/3/4.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kQiniuAccessKey @"86zUP4U5WlSK8QekI2FhReVZPNNvolL_8Pz-bc5U"
#define kQiniuSecretKey @"WOxHj1qqXtSggck_JBii2HmZ28qMkBrDJ4TPMSnj"

#define MESSAGE_ATTR_IS_BIG_EXPRESSION @"em_is_big_expression"

//登陆通知
UIKIT_EXTERN NSString *const UserLoginStatusNotification;
//无登陆通知
UIKIT_EXTERN NSString *const UserLogOutStatusNotification;
//无权限
UIKIT_EXTERN NSString *const NoAuthenOperationNotification;

//微信支付完成通知
UIKIT_EXTERN NSString *const WeCatPayFinishNotification;

//购物车变化通知
UIKIT_EXTERN NSString *const ShoppingCartChangeNotification;
