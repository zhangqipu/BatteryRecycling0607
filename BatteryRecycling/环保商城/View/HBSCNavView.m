//
//  HBSCNavView.m
//  BatteryRecycling
//
//  Created by jiasha.huang on 17/5/16.
//  Copyright © 2016年 bcxx. All rights reserved.
//

#import "HBSCNavView.h"
#import "UtilsHeader.h"

@implementation HBSCNavView

- (void)awakeFromNib{

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(11, 5, 20, 20)];
    image.image = [UIImage imageNamed:@"header_btn_sousu"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    [view addSubview:image];
    
    _textField.leftView = view;
    _textField.leftViewMode = UITextFieldViewModeAlways;

    _gwcNumLab.text = StandardUserDefautsGet(@"gwcnum");
    
}

- (IBAction)messageAction:(UIButton *)sender {
    
    _messageBlock();
    
}

- (IBAction)gwcAction:(UIButton *)sender {
    
    _gWCBlock();
    
}

- (void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
}


@end
