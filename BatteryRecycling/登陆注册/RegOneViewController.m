//
//  RegOneViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/4/30.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "RegOneViewController.h"
#import "RegTwoViewController.h"

@interface RegOneViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *postData;
// 时间计数
@property (nonatomic, assign) NSInteger secondsCountDown;

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic, strong) NSString *codeResult;

@end

@implementation RegOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self initSuberView];
}

- (void)initSuberView
{
    _postData = [NSMutableDictionary dictionary];
    
    [self offsetLeftTextField:_userNameText];
    [self offsetLeftTextField:_passWordText];
    [self offsetLeftTextField:_codeText];
    
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBorad)];
    [self.view addGestureRecognizer:viewTap];
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
- (IBAction)nextAction:(UIButton *)sender {
    
    if ([self check]) {
        RegTwoViewController *vc = [[RegTwoViewController alloc] init];
        vc.userName = _userNameText.text;
        vc.passWord = _passWordText.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (BOOL)check
{
//    if (_userNameText.text.length != 11) {
//        [self showInfoView:@"请填写正确的手机号" infoType:InfoTypeSucceed];
//        return NO;
//        
//    }
//    if (![_code isEqualToString:_codeText.text]) {
//        [self showInfoView:@"验证码填写错误！" infoType:InfoTypeSucceed];
//        return NO;
//    }
    return YES;
}

- (IBAction)codeAction:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager GET:kSmsget parameters:kSmsgetParam(_userNameText.text) success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
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

- (void)hideKeyBorad
{
    [self.view endEditing:YES];
}


@end
