//
//  XGDLMMViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 11/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XGDLMMViewController.h"
#import "XGDLMMFnishViewController.h"

@interface XGDLMMViewController ()

@property (strong, nonatomic) NSString *code;
// 时间计数
@property (nonatomic, assign) NSInteger secondsCountDown;

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic, strong) NSString *codeResult;

@end

@implementation XGDLMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    [self initSuberView];
}

- (void)initSuberView
{
    [self offsetLeftTextField:_codeText];
    
    
    NSString *str1 = [StandardUserDefautsGet(@"user")[@"phone"] substringToIndex:3];
    NSString *str2 = [StandardUserDefautsGet(@"user")[@"phone"] substringFromIndex:7];
    
    _phoneLab.text = [NSString stringWithFormat:@"%@****%@", str1, str2];
}

- (void)offsetLeftTextField:(UITextField *)tf
{
    UIView *leftV   = [UIView new];
    leftV.frame     = CGRectMake(0, 0, 11, 8);
    
    tf.leftView     = leftV;
    tf.leftViewMode = UITextFieldViewModeAlways;
}

/*
 * 下一步
 */
- (IBAction)nextAcion:(id)sender {
    if ([self check]) {
        XGDLMMFnishViewController *vc = [XGDLMMFnishViewController new];
        vc.phoneNum = StandardUserDefautsGet(@"user")[@"phone"];
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

/*
 * 获取验证码
 */
- (IBAction)codeAction:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:kSmsget parameters:kSmsgetParam(StandardUserDefautsGet(@"user")[@"phone"]) success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
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

@end
