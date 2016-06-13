//
//  UtilsMarcos.h
//  BatteryRecycling
//
//  Created by 苹果 on 16/3/27.
//  Copyright © 2016年 wong. All rights reserved.
//

#ifndef UtilsMarcos_h
#define UtilsMarcos_h


#define iOS7                                ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)? NO:YES)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define O_X(v)                            v.frame.origin.x

#define O_Y(v)                            v.frame.origin.y

#define FormatString(string, args...)                  [NSString stringWithFormat:string, args]
//空NULL  等转换成空字符
#define CheckNilValue(object)              [SysTools covertToString:object]

#define LogFrame(frame) NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height)
#define LogPoint(point) NSLog(@"Point[X=%.1f,Y=%.1f]",point.x,point.y)

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］
//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］
//定义UIImage对象
#define ImageNamed(name) [UIImage imageNamed:name]

#define UIFontWithSize( __size__ ) [UIFont systemFontOfSize: __size__]

// 加载xib last
#define LOADNibName(name) [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject]


#define kWeekSelf __weak typeof(self) weakSelf = self;

#define QiNiuToKen @"d6Jb-yev4pxuh55BghOB40hpionVDnjLowZsyxN_:sbbPMDesi7w4P-edPhwWte83OfI=:eyJzY29wZSI6ImltZy1iYW9sdW8iLCJkZWFkbGluZSI6MTQ2MjUyMTE4NSwiaW5zZXJ0T25seSI6MCwiZGV0ZWN0TWltZSI6MCwiZnNpemVMaW1pdCI6MCwiZnNpemVNaW4iOjAsImNhbGxiYWNrRmV0Y2hLZXkiOjB9"
#define ImageDef @"http://pic31.nipic.com/20130719/13219055_061021432102_2.jpg"


#pragma mark -
#pragma mark StandardUserDefaults

#define StandardUserDefautsSet(v, k) \
do { \
     if (v != nil) { \
          [[NSUserDefaults standardUserDefaults] setObject:v forKey:k]; \
          [[NSUserDefaults standardUserDefaults] synchronize]; \
     } \
} while(0)

#define StandardUserDefautsGet(k) \
     [[NSUserDefaults standardUserDefaults] objectForKey:k]

#define StandardUserDefautsRemove(k) \
do { \
    if (k != nil) { \
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:k]; \
     } \
} while(0)


#define kIsLogin [StandardUserDefautsGet(@"isLogin") isEqualToString:@"yes"]


#define kNoPicture [UIImage imageNamed:@"morentouxian"]

#endif /* UtilsMarcos_h */
