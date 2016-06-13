//
//  ZHMMTwoViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "ZHMMTwoViewController.h"
#import "ZHMMThreeViewController.h"

@interface ZHMMTwoViewController ()

// 时间计数
@property (nonatomic, assign) NSInteger secondsCountDown;

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic, strong) NSString *codeResult;

@end

@implementation ZHMMTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    [self initSuberView];
}

- (void)initSuberView
{
    NSString *str1 = [_userName substringToIndex:3];
    NSString *str2 = [_userName substringFromIndex:7];
    
    NSString *phoneStr = [NSString stringWithFormat:@"%@****%@", str1, str2];
    
    NSString *showStr = [NSString stringWithFormat:@"验证码已发送到%@的手机上，120秒内未收到，请重新获取验证码。", phoneStr];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:showStr];
    
//    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff4c4c) range:NSMakeRange(7,phoneStr.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff4c4c) range:NSMakeRange(23,3)];
    
    _lab.attributedText = attributedString;
    
}

/*
 * 验证码事件
 */
- (IBAction)codeAction:(UIButton *)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:kSmsget parameters:kSmsgetParam(_userName) success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _code = responseObject[@"result"];
        
        [self startTimer];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

- (void)startTimer {
    self.secondsCountDown = 120;
    _codeBtn.enabled = NO;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ld 秒后重发",self.secondsCountDown] forState:UIControlStateNormal];
    [_codeBtn setTitleColor:UIColorFromRGB(0xC1C1C1) forState:UIControlStateNormal];
    [_codeBtn setBackgroundColor:UIColorFromRGB(0xF4F4F4)];
    if ((!self.time) || (![self.time isValid])) {
        
        self.time = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                     target:self
                                                   selector:@selector(poolTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    }
    
}
- (void)poolTimer
{
    self.secondsCountDown --;
    if (self.secondsCountDown <= 0) {
        [_codeBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:UIColorFromRGB(0x272636) forState:UIControlStateNormal];
        [_codeBtn setBackgroundColor:UIColorFromRGB(0xF3F4DA)];
        _codeBtn.enabled = YES;
        [self.time invalidate];
        return;
    }
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ld 秒后重发",self.secondsCountDown] forState:UIControlStateNormal];
}


/*
 * 下一步
 */
- (IBAction)nextAction:(UIButton *)sender {
    
    if ([self check]) {
        ZHMMThreeViewController *vc = [ZHMMThreeViewController new];
        vc.phone = _userName;
        
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}

- (BOOL)check
{
    if (![_code isEqualToString:_codeText.text]) {
        [self showInfoView:@"验证码填写错误！" infoType:InfoTypeSucceed];
        return NO;
    }
    return YES;
}

- (void)offsetLeftTextField:(UITextField *)tf
{
    UIView *leftV   = [UIView new];
    leftV.frame     = CGRectMake(0, 0, 11, 8);
    
    tf.leftView     = leftV;
    tf.leftViewMode = UITextFieldViewModeAlways;
}

@end
