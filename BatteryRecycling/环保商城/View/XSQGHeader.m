//
//  XSQGHeader.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 13/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XSQGHeader.h"

@implementation XSQGHeader

- (void)awakeFromNib
{

    if ((!self.time) || (![self.time isValid])) {
        
        self.time = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                     target:self
                                                   selector:@selector(timerFireMethod:)
                                                   userInfo:nil
                                                    repeats:YES];
    }
}


- (NSString *)timerFireMethod:(NSDate *)time{
    
    NSString* string = @"2016-05-20 23:41:06";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    //    NSLog(@"date = %@", [self timerFireMethod:inputDate]);
    
    NSDate *today = [NSDate date];//得到当前时间
    //    NSDate*  startDate  = [ [ NSDate alloc] init ];
    NSDate *startDate = inputDate;
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSUInteger unitFlags =
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:today  toDate: startDate options:0];
    NSInteger diffHour = [cps hour];
    NSInteger diffMin    = [cps minute];
    NSInteger diffSec   = [cps second];
    //    NSLog(  @" From Now to %@, diff: Years: %d  Months: %d, Days; %d, Hours: %d, Mins:%d, sec:%d",
    //          [today description], diffYear, diffMon, diffDay, diffHour, diffMin,diffSec );
    NSString *countdown = [NSString stringWithFormat:@"距离结束:%ld小时 %ld分钟 %ld秒   ", diffHour, diffMin, diffSec];
    if (diffSec<0) {
        countdown=[NSString stringWithFormat:@"拍卖已结束   "];
        
        _hLab.text = @"00";
        _mLab.text = @"00";
        _sLab.text = @"00";
        
        [self.time invalidate];
    } else {
        _hLab.text = [NSString stringWithFormat:@"%02ld", diffHour];
        _mLab.text = [NSString stringWithFormat:@"%02ld", diffMin];
        _sLab.text = [NSString stringWithFormat:@"%02ld", diffSec];
    }
    
    
    return countdown;
}
@end
