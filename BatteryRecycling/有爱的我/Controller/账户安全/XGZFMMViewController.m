//
//  XGZFMMViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 11/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XGZFMMViewController.h"
#import "FinishViewController.h"

@interface XGZFMMViewController ()

@end

@implementation XGZFMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改支付密码";
    [self offsetLeftTextField:_passWordText1];
    [self offsetLeftTextField:_passWordText2];
    
}

- (IBAction)subimAction:(UIButton *)sender {
    
    if ([self check]){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager POST:[NSString stringWithFormat:@"%@?token=%@", kResetPwd, StandardUserDefautsGet(@"token")] parameters:@{@"type":@"payPwd",@"pwd":_passWordText1.text,@"phone":StandardUserDefautsGet(@"user")[@"phone"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if ([responseObject[@"success"] boolValue] == true) {
                NSMutableDictionary *dic = [ToolsObj processDictionaryIsNSNull:responseObject[@"results"]];
                StandardUserDefautsSet(dic, @"user");
                
                FinishViewController *vc = [FinishViewController new];
                vc.navTitle = @"修改支付密码";
                vc.str1 = @"新密码设置成功";
                vc.str2 = @"请牢记您设置的密码";
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
    }
    
    
    
}

- (BOOL)check
{
    if (![_passWordText1.text isEqualToString:_passWordText2.text]) {
        [self showInfoView:@"2次密码不一致" infoType:InfoTypeSucceed];
        return NO;
    } else if (_passWordText1.text.length < 6){
        [self showInfoView:@"密码需大于6位数" infoType:InfoTypeSucceed];
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
