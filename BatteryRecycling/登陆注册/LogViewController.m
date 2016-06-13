//
//  LogViewController.m
//  BatteryRecycling
//
//  Created by 健库 on 16/3/31.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "LogViewController.h"
#import "UtilsHeader.h"
#import "RegOneViewController.h"
#import "ZHMMOneViewController.h"
#import "SFHFKeychainUtils.h"

@interface LogViewController ()
@property (nonatomic, strong) NSMutableDictionary *postData;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xC5CB1A);
    
    _account.text = StandardUserDefautsGet(@"user")[@"phone"];
    _password.text = [SFHFKeychainUtils getPasswordForUsername:_account.text andServiceName:@"Account" error:nil];

}

- (void)showNavBackItem:(BOOL)isShow
{
    [super showNavBackItem:NO];
}

/*
 *  登陆
 */
-(IBAction)btnClick:(id)sender{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager POST:kLogin parameters: @{@"phone":_account.text, @"pwd":_password.text} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([responseObject[@"success"] boolValue] == true) {
            NSMutableDictionary *dic = [ToolsObj processDictionaryIsNSNull:responseObject[@"results"]];
            StandardUserDefautsSet(dic, @"user");
            
            StandardUserDefautsSet(@"yes", @"isLogin");
            
            StandardUserDefautsSet(responseObject[@"token"], @"token");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginStatusNotification object:nil];
            
            [SFHFKeychainUtils storeUsername:_account.text andPassword:_password.text forServiceName:@"Account" updateExisting:YES error:nil];
            [self presentPage];
        } else {
//            responseObject[@"results"]
            [self showInfoView:@"登录失败" infoType:InfoTypeSucceed];
        }

        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showInfoView:@"登录失败" infoType:InfoTypeSucceed];
    }];
    
}


/*
 *  注册
 */
- (IBAction)regAction:(UIButton *)sender {
    
    RegOneViewController *vc = [[RegOneViewController alloc] init];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

/*
 *  找回密码
 */
- (IBAction)findPassWordAction:(UIButton *)sender {
    
    ZHMMOneViewController *vc = [ZHMMOneViewController new];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

-(void)presentPage{
    
    BaseTabBarViewController *tabBarController = [[BaseTabBarViewController alloc] init];
    [self.navigationController presentViewController:tabBarController animated:YES completion:nil];
    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    window.rootViewController = tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
