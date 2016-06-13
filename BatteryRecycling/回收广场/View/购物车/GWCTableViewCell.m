//
//  GWCTableViewCell.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 16/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "GWCTableViewCell.h"

@implementation GWCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NSDictionary *)model
{
    _model = model;
    _xuanzhongBtn.selected = YES;
    [_headerImageView sd_setImageWithURL:model[@"mainPicUrl"] placeholderImage:kNoPicture];
    _nameLab.text = model[@"name"];
    _guigeLab.text = model[@"model"];
    _jiageLab.text = [NSString stringWithFormat:@"￥%@元", model[@"price"]];
    _numText.text = [NSString stringWithFormat:@"%@", model[@"qty"]];
    
    
    if (![[NSString stringWithFormat:@"%@",_model[@"qty"]] isEqualToString:@"1"]) {
        [_jianBtn setBackgroundColor:[UIColor whiteColor]];
        [_jianBtn setTitleColor:UIColorFromRGB(0x272636) forState:UIControlStateNormal];
    }
}

- (void)setDeleteModel:(NSDictionary *)model
{
    _model = model;
    _xuanzhongBtn.selected = YES;
    [_headerImageView sd_setImageWithURL:model[@"mainPicUrl"] placeholderImage:kNoPicture];
    _nameLab.text = model[@"name"];
    _guigeLab.text = model[@"model"];
    _jiageLab.text = [NSString stringWithFormat:@"￥%@元", model[@"price"]];
    _numText.text = [NSString stringWithFormat:@"%@", model[@"qty"]];

    _jiaBtn.enabled = NO;
    _jianBtn.enabled = NO;
    
    [_jiaBtn setBackgroundColor:UIColorFromRGB(0xefefef)];
    [_jiaBtn setTitleColor:UIColorFromRGB(0xd8d8d8) forState:UIControlStateNormal];
    
//    if (![[NSString stringWithFormat:@"%@",_model[@"qty"]] isEqualToString:@"1"]) {
//        [_jianBtn setBackgroundColor:[UIColor whiteColor]];
//        [_jianBtn setTitleColor:UIColorFromRGB(0x272636) forState:UIControlStateNormal];
//    }
}

- (IBAction)xuanzhongAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _xuanZhongBlock(sender);
}

- (IBAction)numAction:(UIButton *)sender {
    
    NSInteger num = [_numText.text integerValue];

    switch (sender.tag) {
        case 1:{
            if (num <= 1) {
                num = 1;
                [_jianBtn setBackgroundColor:UIColorFromRGB(0xefefef)];
                [_jianBtn setTitleColor:UIColorFromRGB(0xd8d8d8) forState:UIControlStateNormal];
            } else {
                [self requestAddOrReduce:@"-"];
            }
           
        }
            break;
            
        default:{
            [self requestAddOrReduce:@"+"];
            
        }
            break;
    }
    
    
}

- (void)requestAddOrReduce:(NSString *)str
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@?token=%@",kCartUpdateQty, StandardUserDefautsGet(@"token")] parameters:@{@"_id":_model[@"_id"], @"type":str} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([responseObject[@"success"] boolValue] == true) {
            _model = responseObject[@"result"];
            
            NSString *gwcstr = StandardUserDefautsGet(@"gwcnum");
            NSInteger nums = [gwcstr integerValue];
            NSInteger num = [_numText.text integerValue];
            
            if ([str isEqualToString:@"+"]){
                nums ++;
                num ++;
                _numText.text = [NSString stringWithFormat:@"%ld", num];
                
                if (![_numText.text isEqualToString:@"1"]) {
                    [_jianBtn setBackgroundColor:[UIColor whiteColor]];
                    [_jianBtn setTitleColor:UIColorFromRGB(0x272636) forState:UIControlStateNormal];
                }
                gwcstr = [NSString stringWithFormat:@"%ld",nums];
                StandardUserDefautsSet(gwcstr, @"gwcnum");
                
            } else {
                nums --;
                num --;
                if (num <= 1) {
                    num = 1;
                    [_jianBtn setBackgroundColor:UIColorFromRGB(0xefefef)];
                    [_jianBtn setTitleColor:UIColorFromRGB(0xd8d8d8) forState:UIControlStateNormal];
                }
                _numText.text = [NSString stringWithFormat:@"%ld", num];
                
                gwcstr = [NSString stringWithFormat:@"%ld",nums];
                StandardUserDefautsSet(gwcstr, @"gwcnum");
            }
            _numBlock(num);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ShoppingCartChangeNotification object:nil];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}


@end
