//
//  ZHMMOneViewController.m
//  BatteryRecycling
//
//  Created by manyu on 16/5/1.
//  Copyright (c) 2016年 bcxx. All rights reserved.
//

#import "ZHMMOneViewController.h"
#import "ZHMMTwoViewController.h"



@interface ZHMMOneViewController ()

@end

@implementation ZHMMOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105, 177, 90, 30)];
    [self.view addSubview:_captchaView];

    
    [self offsetLeftTextField:_userNameText];
    [self offsetLeftTextField:_codeText];
    
}

- (IBAction)nextAction:(UIButton *)sender {
    
    if ([self cheak]) {
        ZHMMTwoViewController *vc = [ZHMMTwoViewController new];
        vc.userName = _userNameText.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (BOOL)cheak
{
    
    if (_userNameText.text.length != 11) {
        [self showInfoView:@"请填写正确的手机号" infoType:InfoTypeSucceed];
        return NO;
        
    }
    
    if ([_codeText.text isEqualToString:_captchaView.changeString]){
        
        return YES;
    } else {
        [self showInfoView:@"验证码填写错误" infoType:InfoTypeSucceed];
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
