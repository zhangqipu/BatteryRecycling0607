//
//  SQHSSViewController.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 5/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SQHSSViewController.h"
#import "CitysViewController.h"
#import "SFZSCViewController.h"

@interface SQHSSViewController ()

@property (nonatomic, strong) NSMutableDictionary *postData;

@end

@implementation SQHSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"回收商申请";
        
    [self initSuberView];
}

- (void)initSuberView
{
    _postData = [NSMutableDictionary dictionary];
    
}
//选中男
- (IBAction)menAction:(UIButton *)sender {
    sender.selected = YES;
    _womenBtn.selected = NO;
}

//选中女
- (IBAction)womenAction:(UIButton *)sender {
    sender.selected = YES;
    _menBtn.selected = NO;
}

//跳转身份证
- (IBAction)cordImageAction:(UIButton *)sender {
    
    SFZSCViewController *vc = [SFZSCViewController new];
    vc.finishUpLoadImageBlock = ^(NSString *url1, NSString *url2){
        [_postData setValue:url1 forKey:@"IDPicUpUrl"];
        [_postData setValue:url2 forKey:@"IDPicDownUrl"];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//地区
- (IBAction)cityAction:(UIButton *)sender {
    
    CitysViewController *vc =[CitysViewController new];
    vc.cityBlock = ^(NSString *citys, NSString *province, NSString *city, NSString *area){
        
        [_cityBtn setTitle:citys forState:UIControlStateNormal];
        [_postData setValue:province forKey:@"province"];
        [_postData setValue:city forKey:@"city"];
        [_postData setValue:area forKey:@"area"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//提交
- (IBAction)subimAction:(UIButton *)sender {
    
    if ([self checkSomeValueIsNull] == YES) return ;
    
    [self setpostData];
    [self requestForMerchantReqAdd];
}

- (BOOL)checkSomeValueIsNull
{
    if ([_nameText.text length] > 0 == NO) {
        return YES;
    }
    
    // ...
    
    return NO;
}

- (void)setpostData
{
    _postData[@"name"] = _nameText.text;
    _postData[@"userId"] = StandardUserDefautsGet(@"user")[@"_id"];
    _postData[@"gender"] = [_menBtn isSelected] ? @"男":@"女";
    // 缺少电话和身份证号等字段录入框
    _postData[@"tel"] = @"123456";
    _postData[@"IDNo"] = _cardIdText.text;
    _postData[@"IDPicUpUrl"] = @"http://img3.imgtn.bdimg.com/it/u=1681882397,3535453166&fm=11&gp=0.jpg";
    _postData[@"IDPicDownUrl"] = @"http://img3.imgtn.bdimg.com/it/u=1681882397,3535453166&fm=11&gp=0.jpg";
    
    NSArray *strs = [_cityBtn.titleLabel.text componentsSeparatedByString:@" "];
    _postData[@"province"] = strs[0];
    _postData[@"city"] = strs[1];
    if (strs.count == 3)
    _postData[@"area"] = strs[2];
    _postData[@"address"] = _adrText.text;
}

#pragma mark - RequestForPost

/**
 *  回收商申请
 */

- (void)requestForMerchantReqAdd
{
    NSString *urlString = [NSString stringWithFormat:@"%@?token=%@", kMerchantReqAdd, StandardUserDefautsGet(@"token")];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [manager POST:urlString parameters:_postData
          success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
     {
         if ([responseObject[@"success"] boolValue] == YES)
             [self showInfoView:@"申请成功!" infoType:InfoTypeSucceed];
         else {
             [self showInfoView:responseObject[@"msg"] infoType:InfoTypeFailed];
         }
    }
          failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
    }];
}

@end
