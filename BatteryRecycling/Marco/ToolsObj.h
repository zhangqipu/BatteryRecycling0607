//
//  ToolsObj.h
//  BaoluoGamePlatform
//
//  Created by jiasha.huang on 23/2/16.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsHeader.h"
#import <UIKit/UIKit.h>

@class InfoModel;
@interface ToolsObj : NSObject

+ (NSArray *)setValuesForKeysWithArray:(NSArray *)jsonModel andModelClass:(Class)modelClass;

//设置行间距
+ (NSMutableAttributedString *)setLineSpacing:(NSString *)str;

//自动计算Lable Size
+ (CGSize)setLableSize:(NSString *)str;

+ (CGSize)setLableSize:(NSString *)str font:(UIFont *)font;

//第一页参数字典
+ (NSDictionary *)firstPageParamDictionry:(NSDictionary *)dic;

//下一页参数字典
+ (NSDictionary *)nextPageParamDictionry:(NSDictionary *)dic;

//切换时间格式
+ (NSString *)setStringFromDate:(NSString *)dateStr;

//得到七牛upload token
+ (NSString *)getUploadTokenWithPolicy:(NSString *)policy;

//获取字典json格式
+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dic;

+ (NSData *)jsonFromDictionary:(NSDictionary *)dic;
//提示
+ (void)setMessage:(NSString *)message AndDelegate:(id)delegate;

// 获取当前显示的控制器
+ (UIViewController *)getCurrentVC;

+ (NSMutableDictionary *)enumerateKeysAndObjectsUsing:(NSMutableDictionary *)dic;

+ (NSString *)jumpToBizPay;

+ (BOOL)IsChinese:(NSString *)str;

// 文字居左上角
+ (CGSize) textLeftTopAlign:(NSString *)str;

// 机型适配
+ (CGFloat)width:(CGFloat)w;
+ (CGFloat)height:(CGFloat)h;

+ (id)processDictionaryIsNSNull:(id)obj;
// 横线
+ (NSAttributedString *)setAttributedString:(NSString *)str;

+ (void)requestGwc;

@end
