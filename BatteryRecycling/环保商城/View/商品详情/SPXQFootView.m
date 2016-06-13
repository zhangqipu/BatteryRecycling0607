//
//  SPXQFootView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 14/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "SPXQFootView.h"
#import "UtilsHeader.h"

@implementation SPXQFootView

- (void)awakeFromNib
{
    _numLab.text = StandardUserDefautsGet(@"gwcnum");
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    
    NSString *userId = StandardUserDefautsGet(@"user")[@"_id"];
    if ([model[@"likeMap"][userId] boolValue] == true) {
        _xihuanLab.textColor = UIColorFromRGB(0xff4c4c);
        _xihuanBtn.selected = YES;
    } else {
        _xihuanLab.textColor = UIColorFromRGB(0xffffff);
        _xihuanBtn.selected = NO;
    }
    
    if ([model[@"collectMap"][userId] boolValue] == true) {
        _shoucangLab.textColor = UIColorFromRGB(0xff4c4c);
        _shouchangBtn.selected = YES;
    } else {
        _shoucangLab.textColor = UIColorFromRGB(0xffffff);
        _shouchangBtn.selected = NO;
    }
    
}

- (IBAction)shoucangAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _shoucangLab.textColor = UIColorFromRGB(0xff4c4c);
        [self requestShoucang];
    }else{
        _shoucangLab.textColor = UIColorFromRGB(0xffffff);
        [self requestDeleteShouCang];
    }
    
    
}
// 请求收藏
- (void)requestShoucang
{
    
//   baseUrl/Favorites/add?token=673b46e080bc36323bc377a0b81ce117
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"http://120.24.0.197:8333/api/Favorites/add?token=%@", StandardUserDefautsGet(@"token")] parameters:@{@"goodsId":_model[@"_id"],@"userId":StandardUserDefautsGet(@"user")[@"_id"], @"title":_model[@"name"],@"model":_model[@"models"][0][@"model"],@"price":_model[@"showPrice"],@"marketPrice":_model[@"showMarketPrice"],@"mainPicUrl":_model[@"mainPicUrl"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

// 取消收藏
- (void)requestDeleteShouCang
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager GET: [NSString stringWithFormat:@"http://120.24.0.197:8333/api/Favorites/delete/%@/%@?token=%@", StandardUserDefautsGet(@"user")[@"_id"], _model[@"_id"], StandardUserDefautsGet(@"token")] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}


- (IBAction)xihuanAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _xihuanLab.textColor = UIColorFromRGB(0xff4c4c);
    }else{
        _xihuanLab.textColor = UIColorFromRGB(0xffffff);
    }
    
    [self requestXihuan];
    
}

// 请求喜欢
- (void)requestXihuan
{

   //http://120.24.0.197:8333/api/Goods/like
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"http://120.24.0.197:8333/api/Goods/like?token=%@", StandardUserDefautsGet(@"token")] parameters:@{@"_id":_model[@"_id"],@"userId":StandardUserDefautsGet(@"user")[@"_id"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)jiaruGouwucheAction:(UIButton *)sender {
    
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@",kCartAdd, StandardUserDefautsGet(@"token")] parameters:@{@"goodsId":_model[@"_id"],@"userId":StandardUserDefautsGet(@"user")[@"_id"], @"name":_model[@"name"],@"model":_model[@"models"][0][@"model"],@"price":_model[@"showPrice"],@"marketPrice":_model[@"showMarketPrice"],@"mainPicUrl":_model[@"mainPicUrl"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSInteger num = [_numLab.text integerValue];
        num ++;
        _numLab.text = [NSString stringWithFormat:@"%ld", num];
       
        StandardUserDefautsSet(_numLab.text, @"gwcnum");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ShoppingCartChangeNotification object:nil];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}

- (IBAction)gouMaiAction:(UIButton *)sender {
    _liJiGouMaiBlock();
}


@end
