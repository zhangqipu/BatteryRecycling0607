//
//  XGNCViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 10/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XGNCViewController.h"

@interface XGNCViewController ()

@end

@implementation XGNCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改昵称";
    [self offsetLeftTextField:_text];
}

- (void)request
{
    
    
    if (_text.text.length != 0) {
        
//        [self showIndicatorView];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        [manager POST:[NSString stringWithFormat:@"%@?token=%@", kUpdateUserInfo, StandardUserDefautsGet(@"token")] parameters:@{@"type":@"name",@"name":_text.text,@"_id":StandardUserDefautsGet(@"user")[@"_id"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if ([responseObject[@"success"] boolValue] == true) {
                
                _finishEdit(_text.text);
                
                NSMutableDictionary *user = [NSMutableDictionary dictionaryWithDictionary:StandardUserDefautsGet(@"user")];
                [user setObject:_text.text forKey:@"name"];
                StandardUserDefautsSet(user, @"user");
                
                [self.navigationController popViewControllerAnimated:YES];
            }
//             [self hideIndicatorView];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            [self hideIndicatorView];
        }];
    }
    
    
}
- (IBAction)saveAction:(UIButton *)sender {
    [self request];
}

- (void)offsetLeftTextField:(UITextField *)tf
{
    UIView *leftV   = [UIView new];
    leftV.frame     = CGRectMake(0, 0, 11, 8);
    
    tf.leftView     = leftV;
    tf.leftViewMode = UITextFieldViewModeAlways;
}


@end
