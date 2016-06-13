//
//  ToolsObj.m
//  BaoluoGamePlatform
//
//  Created by jiasha.huang on 23/2/16.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "ToolsObj.h"
#import "UtilsHeader.h"
#import <CommonCrypto/CommonHMAC.h>
#import <Foundation/Foundation.h>

@implementation ToolsObj

+ (NSArray *)setValuesForKeysWithArray:(NSArray *)jsonModel andModelClass:(Class)modelClass
{
    if (jsonModel.count == 0)  return @[];
    
    NSMutableArray *myGameArr = [NSMutableArray array];
    for (int i = 0; i < jsonModel.count;  i ++) {
        NSObject *myGame = [[modelClass class] new];
        [myGame setValuesForKeysWithDictionary:jsonModel[i]];
        [myGameArr addObject:myGame];
    }
    
    return myGameArr;
}

+ (NSMutableAttributedString *)setLineSpacing:(NSString *)str
{
    if (str == nil) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    return attributedString;
}

+ (CGSize)setLableSize:(NSString *)str
{
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    
    CGRect size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 22 , 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return size.size;
}

+ (CGSize)setLableSize:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGRect size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 22 , 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    return size.size;
}

+ (NSDictionary *)firstPageParamDictionry:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [mdic setValue:[NSString stringWithFormat:@"%@", @1] forKey:@"page"];
    
    return mdic;
}
+ (NSDictionary *)nextPageParamDictionry:(NSDictionary *)dic
{
    NSMutableDictionary *mdic;
    
    // 如果有分页
    if (dic[@"page"]) {
        mdic     = [[NSMutableDictionary alloc] initWithDictionary:dic];
        int page = [dic[@"page"] intValue];
        
        [mdic setValue:[NSString stringWithFormat:@"%@", [NSNumber numberWithInt:page + 1]] forKey:@"page"];
    }
    
    return mdic;
}

+ (NSString *)setStringFromDate:(NSString *)dateStr
{
//    2016-03-10T08:14:33.262Z
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"YYYY-MM-ddTHH:mm:ss.sssZ";
    NSDate *date = [fomatter dateFromString:dateStr];
    NSLog(@"%@", [fomatter dateFromString:dateStr]);
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:date];
    NSLog(@"testDate:%@", str);
    
    return str;
}



+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSData *)jsonFromDictionary:(NSDictionary *)dic
{
    if (dic == nil)
        return nil;
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"[post json] = %@",str);
    return jsonData;
}

+ (void)setMessage:(NSString *)message AndDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}

// 获取当前显示的控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSMutableDictionary *)enumerateKeysAndObjectsUsing:(NSMutableDictionary *)dic
{
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [d enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            [d setValue:@"" forKey:key];
        }
    }];
    
    return d;
}


//判断字符是否有中文
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
            }
    }
    return NO;
}



+ (CGSize) textLeftTopAlign:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
//    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    return labelSize;
}


+ (CGFloat)width:(CGFloat)w
{
    CGFloat num;
    if (CGRectGetWidth([[UIScreen mainScreen] bounds]) == 320){
        num = w / 1.171875;
    }else if (CGRectGetWidth([[UIScreen mainScreen] bounds]) == 375){
        return w;
    }else if (CGRectGetWidth([[UIScreen mainScreen] bounds]) >= 414){
        num = w * 1.104;
    }
    return num;
}

+ (CGFloat)height:(CGFloat)h
{
    CGFloat num;
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) == 480) {
        num = h / 1.174296 / 1.183333;
    }else if (CGRectGetHeight([[UIScreen mainScreen] bounds]) == 568){
        num = h / 1.174296;
    }else if (CGRectGetHeight([[UIScreen mainScreen] bounds]) == 667){
        return h;
    }else if  (CGRectGetHeight([[UIScreen mainScreen] bounds]) >= 736){
        num = h *1.103;
    }
    return num;
}

+ (id) processDictionaryIsNSNull:(id)obj
{
    const NSString *blank = @"";
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            const id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da forKey:key];
                
            }
        }
        return [dt copy];
    } else if ([obj isKindOfClass:[NSArray class]]){
        
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    } else {
        return obj;
    }
}


+ (NSAttributedString *)setAttributedString:(NSString *)str
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(1, str.length - 1)];
    
    return attributedString;
}

+ (void)requestGwc
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:[NSString stringWithFormat:@"%@?token=%@", kCart, StandardUserDefautsGet(@"token")]
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             if ([responseObject[@"success"] boolValue] == true) {
                 NSMutableArray *arr = [NSMutableArray array];
                 [arr addObjectsFromArray:responseObject[@"result"]];
                 
                 NSInteger num = 0;
                 
                 for (NSDictionary *dic in arr) {
                     NSString *numstr = dic[@"qty"];
                     num += [numstr integerValue];
                 }
                 
                 NSString *str = [NSString stringWithFormat:@"%ld", num];
                 StandardUserDefautsSet(str, @"gwcnum");
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:ShoppingCartChangeNotification object:nil];
                 
             }
         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             NSLog(@"%@", error);
         }];
}

@end
