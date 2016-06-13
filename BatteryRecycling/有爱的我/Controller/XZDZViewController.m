//
//  XZDZViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 10/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "XZDZViewController.h"
#import "CitysViewController.h"

@interface XZDZViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *postData;

@end

@implementation XZDZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增收货地址";
    [self initSuberView];
}

- (void)initSuberView
{
    _postData = [NSMutableDictionary dictionary];
    _cityText.delegate = self;
}

- (IBAction)saveAction:(UIButton *)sender {
    
    [self setPostData];
}

- (void)setPostData
{
    if ([self cheak]) {
        [_postData setObject:@"add" forKey:@"type"];
        [_postData setObject:StandardUserDefautsGet(@"user")[@"_id"] forKey:@"_id"];
        [_postData setObject:_nameText.text forKey:@"name"];
        [_postData setObject:_adrText.text forKey:@"address"];
        [_postData setObject:_phoneText.text forKey:@"phone"];
        
        
        [self request];
    }
    
}

- (void)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@",kUpdateUserAddrInfo, StandardUserDefautsGet(@"token")] parameters:_postData success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([responseObject[@"success"] boolValue] == true) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _cityText){
        CitysViewController *vc =[CitysViewController new];
        vc.cityBlock = ^(NSString *citys, NSString *province, NSString *city, NSString *area){
            
            _cityText.text = citys;
            [_postData setValue:province forKey:@"province"];
            [_postData setValue:city forKey:@"city"];
            [_postData setValue:area forKey:@"area"];
            
        };
        [self.navigationController pushViewController:vc animated:YES];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)cheak
{
    if (_nameText.text.length == 0) {
        [self showInfoView:@"请填写收货人姓名" infoType:InfoTypeSucceed];
        return NO;
    }
    if (_phoneText.text.length != 11) {
        [self showInfoView:@"请填写正确的手机号码" infoType:InfoTypeSucceed];
        return NO;
    }
    if (_cityText.text.length == 0){
        [self showInfoView:@"请选择所在地区" infoType:InfoTypeSucceed];
        return NO;
    }
    if (_adrText.text.length == 0){
        [self showInfoView:@"请填写详细地址" infoType:InfoTypeSucceed];
        return NO;
    }
    return YES;
}


@end
