//
//  DZGLTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 9/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "DZGLTableViewCell.h"

@implementation DZGLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    
    _nameLab.text = model[@"name"];
    if ([model[@"selected"] boolValue] == true) {
        _selectBtn.selected = YES;
    }
    
    NSString *str1 = [model[@"phone"] substringToIndex:3];
    NSString *str2 = [model[@"phone"] substringFromIndex:7];
    
    NSString *phoneStr = [NSString stringWithFormat:@"%@****%@", str1, str2];
    _phoneLab.text = phoneStr;
    
    _adrLab.text = [NSString stringWithFormat:@"%@%@%@%@",model[@"province"], model[@"city"], model[@"area"],model[@"address"]];
    
}

// 设置为默认
- (IBAction)selectAction:(UIButton *)sender {
    
    sender.selected = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@",kUpdateUserAddrInfo, StandardUserDefautsGet(@"token")] parameters:@{@"type":@"select", @"_id":StandardUserDefautsGet(@"user")[@"_id"], @"addrId": _model[@"addrId"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

// 删除
- (IBAction)delAction:(UIButton *)sender {
    sender.selected = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@",kUpdateUserAddrInfo, StandardUserDefautsGet(@"token")] parameters:@{@"type":@"remove", @"_id":StandardUserDefautsGet(@"user")[@"_id"], @"addrId": _model[@"addrId"]} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([responseObject[@"result"] boolValue] == true) {
            _deleteAdr();
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}


@end
